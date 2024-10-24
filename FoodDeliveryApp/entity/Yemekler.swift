//
//  Yemekler.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//

import Foundation
import Alamofire
import RxSwift
import Kingfisher

class Yemekler: Codable {
    
    var yemek_id:String?
    var yemek_adi:String?
    var yemek_resim_adi:String?
    var yemek_fiyat:String?
    
    
    init (yemek_id:String,yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:String){
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
    }
}
