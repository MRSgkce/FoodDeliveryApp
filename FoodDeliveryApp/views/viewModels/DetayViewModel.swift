//
//  DetayViewModel.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//
import Foundation
import RxSwift
import Alamofire
import RxSwift
import Kingfisher

class DetayViewModel{
    var yrepo = YemeklerDaoRepository()
    
    func sepeteEkle(yemek: Yemekler, adet: Int, kullaniciAdi: String, completion: @escaping (Result<Any, Error>) -> Void) {
        yrepo.sepeteEkle(yemek: yemek, adet: adet, kullaniciAdi: kullaniciAdi, completion: completion)
        }
}
