//
//  GalleryViewModel.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import Foundation
import UIKit

typealias PostParameter = (Post) -> Void
struct Post {
    var id: String
    var url: String
    var likes: Int
    var likedByUser: Bool
    var username: String
    
}

class GalleryViewModel: (GalleryViewModelProtocol){
    
    public var imageRepository: ImageRepository?
    
    var newCountOfPosts: Observable<Int> = Observable(0)
    var uptodatePosts: [Post]!
    init(imageRepository: ImageRepository = ImageRepository()){
        self.imageRepository = imageRepository
    }
    func getListPhoto() {
        imageRepository!.getListImage(page: newCountOfPosts.value/Constant.numberOfPostsPerPage){ postModels in
            var localPosts = [Post]()
            for postModel in postModels{
                let post = Post(id: postModel.id, url: postModel.urls.regularSize, likes: postModel.likes, likedByUser: postModel.likedByUser, username: postModel.user.username)
                localPosts.append(post)
            }
            self.newCountOfPosts.value = localPosts.count
            self.uptodatePosts = localPosts
        }
    }
    // Don't use the "binding method" to avoid reloading all table. It is need to just update one cell
    func handleLikeDislikeClick(imageId: String, isLiked: Bool, completion: @escaping PostParameter) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.imageRepository?.likeDislikeImage(imageId: imageId, isLiked: isLiked) {
                let indexOfPost = self.uptodatePosts.firstIndex(where: {$0.id == imageId})!;
                let currentPost = self.uptodatePosts[indexOfPost]
                var updatedPost = currentPost
                if(isLiked){
                   //isLiked so that we need to toggle it to Dislike
                    updatedPost.likedByUser = false;
                    updatedPost.likes -= 1
                }
                else{
                    updatedPost.likedByUser = true;
                    updatedPost.likes += 1
                }
                //Use for update specificCell
                completion(updatedPost)
                //store all up to dated cell and avoid reload table by using newPosts variable
                self.uptodatePosts[indexOfPost] = updatedPost
                //self.newPosts.value[indexOfPost] = updatedPost
                
            }
        }
    }
    func loadMoreData(completion: VoidClosure) {
        if(newCountOfPosts.value < Constant.maximumPosts) {
            imageRepository!.getListImage(page: newCountOfPosts.value/Constant.numberOfPostsPerPage + 1) { postModels in
                var localPosts = [Post]()
                for postModel in postModels{
                    let post = Post(id: postModel.id, url: postModel.urls.regularSize, likes: postModel.likes, likedByUser: postModel.likedByUser, username: postModel.user.username)
                    localPosts.append(post)
                }
                self.uptodatePosts.append(contentsOf: localPosts)
                self.newCountOfPosts.value = self.uptodatePosts.count
            }
        }
        else {
            print("Maximum post loaded.")
        }
        completion()

    }
    
}
