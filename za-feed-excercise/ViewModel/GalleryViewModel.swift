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

class GalleryViewModel: GalleryViewModelProtocol{
    
    public var imageRepository: ImageRepository?
    
    var posts: Observable<[Post]> = Observable([])
    
    init(imageRepository: ImageRepository = ImageRepository()){
        self.imageRepository = imageRepository
    }
    func getListPhoto() {
        imageRepository!.getListImage { postModels in
            var localPosts = [Post]()
            for postModel in postModels{
                let post = Post(id: postModel.id, url: postModel.urls.regularSize, likes: postModel.likes, likedByUser: postModel.likedByUser, username: postModel.user.username)
                localPosts.append(post)
            }
            self.posts.value = localPosts
        }
    }
    // Don't use the "binding method" to avoid reloading all table. It is need to just update one cell
    func handleLikeDislikeClick(imageId: String, isLiked: Bool, currentPost: Post, completion: @escaping PostParameter) {
        imageRepository?.likeDislikeImage(imageId: imageId, isLiked: isLiked) {
            //let indexOfPost = self.posts.value.firstIndex(where: {$0.id == imageId})!;
            //var currentPost = self.posts.value[indexOfPost]
            var newPost = currentPost
            if(isLiked){
               //isLiked so that we need to toggle it to Dislike
                newPost.likedByUser = false;
                newPost.likes -= 1
            }
            else{
                newPost.likedByUser = true;
                newPost.likes += 1
            }
            completion(newPost)
        }
    }
    
}
