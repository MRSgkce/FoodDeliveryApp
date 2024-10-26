//
//  Sepet.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//

import Foundation
import Alamofire
import RxSwift
import Kingfisher

/*class Sepet: Codable {
    
    var yemek_adi:String?
    var yemek_resim_adi:String?
    var yemek_fiyat:Int?
    var yemek_siparis_adet:Int?
    var kullanici_adi:String?
    
    init(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
        self.kullanici_adi = kullanici_adi
    }
    
}*/

class Sepet: Codable {
    var sepet_yemek_id: String?
    var kullanici_adi: String?
    var yemek_adi: String?
    var yemek_resim_adi: String?
    var yemek_fiyat: String?
    var yemek_siparis_adet: String?

    init(sepet_yemek_id: String?, kullanici_adi: String?, yemek_adi: String?, yemek_resim_adi: String?, yemek_fiyat: String?, yemek_siparis_adet: String?) {
        self.sepet_yemek_id = sepet_yemek_id
        self.kullanici_adi = kullanici_adi
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
    }
}
