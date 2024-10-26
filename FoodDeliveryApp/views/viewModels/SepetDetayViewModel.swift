//
//  SepetDetayViewModel.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//
import Foundation
import RxSwift
import Alamofire
import RxSwift
import Kingfisher

/*class SepetDetayViewModel {
    var yrepo = YemeklerDaoRepository()
    var sepetListesi = BehaviorSubject<[Sepet]>(value: [Sepet]())
    
    init() {
        sepetListesi = yrepo.
        yemekleriYukle()
    }
    
    func yemekleriYukle() {
        yrepo.sepetiGoster(kullanici_adi: String)
    }
    
}*/





class SepetDetayViewModel {
    func sepetiGoster(kullaniciAdi: String, completion: @escaping (Result<[Sepet], Error>) -> Void) {
        let params: Parameters = ["kullanici_adi": kullaniciAdi]

        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            print("Response: \(response)") // Yanıtı kontrol etmek için ekleyin
            
            if let data = response.data {
                do {
                    // Yanıtı SepetYemeklerCevap modeli ile decode et
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    
                    if let sepetListesi = cevap.sepet {
                        completion(.success(sepetListesi)) // Sepet listesini döndür
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sepette yemek bulunamadı."])))
                    }
                } catch {
                    completion(.failure(error))
                    print("Decoding Error: \(error.localizedDescription)")
                }
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}
