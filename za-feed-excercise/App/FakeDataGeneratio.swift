//
//  FakeDataGeneratio.swift
//  za-feed-excercise
//
//  Created by NhanHuuTa on 24/03/2022.
//


import Foundation

final class FakeDataGenerator {
    typealias DecoderObject  = NSObject & Codable
    
    static let  shared = FakeDataGenerator()
    func getJSON_Data(fileName: String) -> Data? {
       if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
           do {
                 let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                 return data
             } catch {
                  // handle error
                   print("error, not found")
             }
       }
       return nil
   }
}
