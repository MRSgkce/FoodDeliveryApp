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
    
    
    
    
    
  
    
    
    func sepeteEkle(yemek: Yemekler, adet: Int, kullaniciAdi: String, completion: @escaping (Result<Any, Error>) -> Void) {
            let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
            
            let parameters: [String: Any] = [
                "yemek_adi": yemek.yemek_adi!,
                "yemek_resim_adi": yemek.yemek_resim_adi!,
                "yemek_fiyat": yemek.yemek_fiyat!,
                "yemek_siparis_adet": adet,
                "kullanici_adi": kullaniciAdi
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    
    }


