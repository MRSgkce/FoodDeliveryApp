//
//  YemeklerDaoRepository.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//

import Foundation
import RxSwift
import Alamofire
import Kingfisher

class YemeklerDaoRepository {
    var YemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    /*func YemekleriYukle() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get) .response { response in
            if let data = response.data{
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    
                    if let liste = cevap.yemekler{
                        self.YemeklerListesi.onNext(liste)
                    }
                    
                }catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
*/
    
    

        
        func YemekleriYukle() {
            AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
                if let data = response.data {
                    do {
                        let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                        
                        if let liste = cevap.yemekler {
                            self.YemeklerListesi.onNext(liste)
                        }
                        
                    } catch {
                        print("JSON Decode Hatası:", error.localizedDescription)
                    }
                } else if let error = response.error {
                    print("Network Hatası:", error.localizedDescription)
                }
            }
        }
    }


