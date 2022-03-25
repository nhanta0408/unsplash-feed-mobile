//
//  ImageRepository.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import Foundation
import UIKit
typealias VoidClosure = () -> Void
typealias PostsModelParameter = ([PostModel]) -> Void

class ImageRepository{
    var postModels: [PostModel]?

    func getListImage(completion: @escaping PostsModelParameter)  {
        let urlString = Constant.basetApiUrl + "/photos?page=1&per_page=10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        //Đưa vào thread global
        DispatchQueue.global(qos: .userInitiated).async {
            let task = URLSession(configuration: .default).dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
                guard let data = data else {
                        return }
                do {
                    self.postModels = try JSONDecoder().decode([PostModel].self, from: data)
                        completion(self.postModels ?? [PostModel]())
                } catch let e {
                    print("Error ne: " + e.localizedDescription)
                }
                
            }
            task.resume()
        }
    }
    func likeDislikeImage(imageId: String, isLiked: Bool, completion: @escaping VoidClosure) {
        let urlString = Constant.basetApiUrl + "/photos/\(imageId)/like"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = isLiked ?  "DELETE" : "POST"
        //Đưa vào thread global
        DispatchQueue.global(qos: .userInitiated).async {
            let task = URLSession(configuration: .default).dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
                guard let httpResponse = response as?HTTPURLResponse else{
                            print("Lỗi cast")
                            return
                        }
                if (200...299).contains(httpResponse.statusCode) {
                    print(httpResponse.statusCode)
                    print((isLiked ? "Dislike" : "Like") + " successfully")
                    DispatchQueue.main.async {
                      completion()
                    }
                }
                else{
                    print(httpResponse.statusCode)
                    print("Liked/Dislike failed")
                }
            }
            task.resume()
        }
    }
}
