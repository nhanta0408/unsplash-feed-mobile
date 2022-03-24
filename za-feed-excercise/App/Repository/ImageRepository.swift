//
//  ImageRepository.swift
//  za-feed-excercise
//
//  Created by gcshcm on 24/03/2022.
//

import Foundation
import UIKit

class ImageRepository{
    func getListImage() -> [PostModel]{
        var postModels: [PostModel]?
        let urlString = Constant.basetApiUrl + "/photos?page=1&per_page=10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession(configuration: .default).dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {
                    return }
            print("data laf: " + String(decoding: data, as: UTF8.self))
            do {
                postModels = try! JSONDecoder().decode([PostModel].self, from: data)
            } catch let e {
                print(e.localizedDescription)
            }
            print("  laf \(postModels?.first?.user.username)")

        }
            task.resume()
        return postModels ?? [PostModel]()
    }
    
}
