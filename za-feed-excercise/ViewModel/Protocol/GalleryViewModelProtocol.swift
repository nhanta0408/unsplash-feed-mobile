//
//  GalleryProtocol.swift
//  za-feed-excercise
//
//  Created by gcshcm on 25/03/2022.
//

import Foundation

protocol GalleryViewModelProtocol{
    var imageRepository: ImageRepository? {get}
    var posts: Observable<[Post]> {get set}
    func getListPhoto()
    func handleLikeDislikeClick(imageId: String, isLiked: Bool, currentPost: Post, completion: @escaping PostParameter) 
    
}
