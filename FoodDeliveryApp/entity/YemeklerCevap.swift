//
//  YemeklerCevap.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//

import Foundation
import Alamofire
import Kingfisher

class YemeklerCevap: Codable {
    var yemekler: [Yemekler]?
    var success: Int?
    
    private enum CodingKeys: String, CodingKey {
        case yemekler = "yemekler"
        case success = "success"
    }
}

