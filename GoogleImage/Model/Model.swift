//
//  Model.swift
//  GoogleImage
//
//  Created by MAC13 on 07.02.2023.
//

import Foundation
import UIKit

var results: [Result] = []
//var indexMain: Int = 0
var indexForImage = IndexImage()

struct APIResponse: Decodable{
    var images_results: [Result]
}

class IndexImage {
    var indexMain: Int = 0
}

struct Result: Codable{
    var thumbnail: String
    var link: String
}

func request(query: String, complitionHandler: (()->Void)?){
    let urlString = "https://serpapi.com/search.json?q=\(query)&tbm=isch&ijn=0&api_key=32fa08bae875f81fc73f39f36166330a256838d92051819dda4bfa11fb861620"
    guard let url = URL(string: urlString) else {
        return
    }
 //   guard let self = self else { return }

    let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
        guard let data = data, error == nil  else {
            return
        }
        
        do {
            let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                results = jsonResult.images_results
                complitionHandler?()
            }
            print(jsonResult.images_results.count)
        }
        catch {
            print(error)
        }
    }
    task.resume()
}

