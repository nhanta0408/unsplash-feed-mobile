//
//  GalleryProtocol.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 25/03/2022.
//

import Foundation

protocol GalleryViewModelProtocol{
    var imageRepository: ImageRepository? {get}
    var newCountOfPosts: Observable<Int> {get set}
    var uptodatePosts: [Post] {get set}
    func getListPhoto()
    func handleLikeDislikeClick(imageId: String, isLiked: Bool, completion: @escaping PostParameter) 
    func loadMoreData(completion: VoidClosure)
}
