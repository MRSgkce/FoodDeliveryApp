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
    
    
    /*func sepetiGoster(kullanici_adi:String){
     let params:Parameters = ["kullanici_adi":kullanici_adi]
     
     AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response { response in
     if let data = response.data {
     do{
     let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
     print("Başarı : \(cevap.success!)")
     print("Mesaj  : \(cevap.message!)")
     
     }catch{
     print(error.localizedDescription)
     }
     }
     }
     }
     */
    
    func sepetiGoster(kullaniciAdi: String, completion: @escaping (Result<[Sepet], Error>) -> Void) {
        let params: Parameters = ["kullanici_adi": kullaniciAdi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            // Yanıtı string olarak konsola yazdır
            if let data = response.data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response String: \(responseString)") // Yanıtı konsola yazdır
                }
                
                do {
                    // JSON yanıtını SepetYemeklerCevap modeline decode et
                    let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    
                    // Gelen sepet verilerini kontrol et
                    if let sepetListesi = cevap.sepet {
                        completion(.success(sepetListesi))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Sepet verisi bulunamadı."])))
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


