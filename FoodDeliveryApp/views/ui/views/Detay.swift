//
//  Detay.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//

import Foundation
import Alamofire
import RxSwift
import Kingfisher
import UIKit

class Detay: UIViewController {
    
    @IBOutlet weak var imageDetay: UIImageView!
    
    @IBOutlet weak var adetSayisi: UILabel!
    @IBOutlet weak var labelFiyat: UILabel!
    @IBOutlet weak var stackBilgiler: UIStackView!
    var sepetteadet:Int = 3
    
    var yemek:Yemekler?
    
    
    var viewModel = DetayViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adetSayisi.text = String( sepetteadet )
        
        if let ye = yemek {
            if let imageurl = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(ye.yemek_resim_adi!)"){
                self.imageDetay.kf.setImage(with: imageurl)
            }
            labelFiyat.text="\(ye.yemek_fiyat!) TL"

        }

        
    }
    
    
    
    
    @IBAction func adeteksi(_ sender: Any) {
        if sepetteadet > 1 { // En az 1 adet olmalı
            sepetteadet -= 1 // sepetteadet değerini azaltıyoruz
            adetSayisi.text = String(sepetteadet) // Yeni değeri gösteriyoruz
        }
    }

    @IBAction func adetarti(_ sender: Any) {
        sepetteadet += 1 // sepetteadet değerini artırıyoruz
        adetSayisi.text = String(sepetteadet) // Yeni değeri gösteriyoruz
    }

    
    /*
    @IBAction func SepeteEkleButonu(_ sender: Any) {
        guard let yemek = yemek else { return }
        
        let kullaniciAdi = "murside_gokce" // Kendi belirlediğin kullanıcı adını buraya yaz
        let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        
        let parameters: [String: Any] = [
            "yemek_adi": yemek.yemek_adi!,
            "yemek_resim_adi": yemek.yemek_resim_adi!,
            "yemek_fiyat": yemek.yemek_fiyat!,
            "yemek_siparis_adet": sepetteadet,
            "kullanici_adi": kullaniciAdi
        ]
        
            AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Başarıyla sepete eklendi: \(value)")
                // İsteğe göre, burada kullanıcıya bir bildirim veya görsel geri bildirim verebilirsin.
            case .failure(let error):
                print("Sepete eklerken hata oluştu: \(error)")
                // Hata mesajını kullanıcıya göstermek için bir uyarı ekleyebilirsin.
            }
        }
    }

    
    */
    
    @IBAction func SepeteEkleButonu(_ sender: Any) {
        guard let yemek = yemek else { return }
        let kullaniciAdi = "murside_gokce"
        
        viewModel.sepeteEkle(yemek: yemek, adet: sepetteadet, kullaniciAdi: kullaniciAdi) { result in
            switch result {
            case .success(let value):
                print("Başarıyla sepete eklendi: \(value)")
            case .failure(let error):
                print("Sepete eklerken hata oluştu: \(error)")
            }
        }
    }

    
    
    
    
       
    
   
    
}
