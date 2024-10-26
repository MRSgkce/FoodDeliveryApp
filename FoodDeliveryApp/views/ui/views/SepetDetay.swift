//
//  SepetDetay.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//


import Foundation
import Alamofire
import RxSwift
import Kingfisher
import UIKit

/*
class SepetDetay: UIViewController{
    
    @IBOutlet weak var yemekfiyati: UILabel!
    @IBOutlet weak var yemekadeti: UILabel!
    @IBOutlet weak var sepetyemekismi: UILabel!
    @IBOutlet weak var sepetimage: UIImageView!
    //var sepetListesi = [Sepet]()
    var viewModel = SepetDetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
}*/





class SepetDetay: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableviewsepet: UITableView!

    var viewModel = SepetDetayViewModel()
    let kullaniciAdi = "kullaniciAdiniz"  // Kullanıcı adı burada belirtilecek
    var yemekListesi: [Sepet] = [] // Yemekleri tutacak dizi

    override func viewDidLoad() {
        super.viewDidLoad()

        // TableView delegate ve data source ayarları
        tableviewsepet.delegate = self
        tableviewsepet.dataSource = self

        // Sepet verisini al
        viewModel.sepetiGoster(kullaniciAdi: kullaniciAdi) { result in
            switch result {
            case .success(let yemekListesi):
                DispatchQueue.main.async {
                    self.yemekListesi = yemekListesi // Gelen yemekleri diziye ata
                    self.tableviewsepet.reloadData() // TableView'ı güncelle
                }
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
            }
        }
    }

    // UITableViewDataSource fonksiyonları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekListesi.count // Yemek sayısını döndür
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SepetCell", for: indexPath)

        let yemek = yemekListesi[indexPath.row] // İlgili yemeği al

        // Hücreye yemek adını ve fiyatını ata
        cell.textLabel?.text = yemek.yemek_adi // Yemek adını hücreye ata
        cell.detailTextLabel?.text = "\(yemek.yemek_fiyat ?? "0") ₺" // Yemek fiyatını hücreye ata
        
        // Resmi yüklemek için Kingfisher kullanıyorsanız
        if let resimAdi = yemek.yemek_resim_adi {
            let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(resimAdi)")
            cell.imageView?.kf.setImage(with: url) // Kingfisher ile resmi yükle
        }

        return cell // Hücreyi döndür
    }
}
