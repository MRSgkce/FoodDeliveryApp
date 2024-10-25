//
//  ViewController.swift
//  FoodDeliveryApp
//
//  Created by Mürşide Gökçe on 25.10.2024.
//
import Foundation
import Alamofire
import RxSwift
import Kingfisher
import UIKit

class Anasayfa: UIViewController {

    var yemeklerListesi = [Yemekler]()
    
    var viewModel = AnasayfaViewModel()
    @IBOutlet weak var YemeklerColelctionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        YemeklerColelctionView.delegate = self
        YemeklerColelctionView.dataSource = self
        
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            DispatchQueue.main.async {
                self.YemeklerColelctionView.reloadData()
            }
        })
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        //10 X 10 X 10 = 30
        //15 X 10 X 10 X 15 = 50
        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik - 30) / 2
        
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik*1.6)
        
        YemeklerColelctionView.collectionViewLayout = tasarim
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let yemek = sender as? Yemekler {
                let gidilecekVC = segue.destination as! Detay
                gidilecekVC.yemek = yemek
            }
        }
    }


}

extension Anasayfa: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemeklerListesi[indexPath.row]
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "yemeklerHucre", for: indexPath) as! yemeklerHucre
        
       // hucre.imageViewYemek.image = UIImage(named: yemek.yemek_resim_adi!)
        
        /*if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/\(yemek.yemek_resim_adi!)"){
            DispatchQueue.main.async{
                hucre.imageViewYemek.kf.setImage(with: url)
            }}*/
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)") {
            hucre.imageViewYemek.kf.setImage(with: url, completionHandler: { result in
                switch result {
                case .success(let value):
                    print("Resim yüklendi: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Resim yükleme hatası: \(error.localizedDescription)")
                }
            })
        }




        hucre.labelYemekFiyat.text = "\(yemek.yemek_fiyat!) TL"
        
        hucre.layer.borderColor=UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10.0
        
        return hucre
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    
    
 
    
}
