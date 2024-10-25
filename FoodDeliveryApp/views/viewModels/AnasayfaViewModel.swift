//
//  AnasayfaViewModel.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//

import Foundation
import RxSwift
import Alamofire
import RxSwift
import Kingfisher

class AnasayfaViewModel {
    var yrepo = YemeklerDaoRepository()
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    init() {
        yemeklerListesi = yrepo.YemeklerListesi
        yemekleriYukle()
    }
    
    func yemekleriYukle() {
        yrepo.YemekleriYukle()
    }
    
}
