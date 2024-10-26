//
//  SepetYemeklerCevap.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 26.10.2024.
//

import Foundation
import Alamofire
import Kingfisher

class SepetYemeklerCevap: Codable {
    var sepet: [Sepet]?
    var success: Int?

    private enum CodingKeys: String, CodingKey {
        case sepet
        case success
    }
}

