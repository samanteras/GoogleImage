//
//  Model.swift
//  GoogleImage
//
//  Created by MAC13 on 07.02.2023.
//

import Foundation
import UIKit


struct APIResponse: Decodable{
    var images_results: [Result]
}


struct Result: Codable{
    var thumbnail: String
    var link: String
}

