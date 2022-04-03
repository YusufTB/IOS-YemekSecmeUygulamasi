//
//  AnasayfaVC.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 28.03.2022.
//

import UIKit
import Firebase
import Alamofire
import Kingfisher

class AnasayfaVC: UIViewController {

    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    @IBOutlet weak var deliveryAddressTF: DesignableUITextField!
    
    var yemeklerListesi = [Yemekler]()
    var tempYemeklerListesi = [Yemekler]()
    
    var anasayfaPresenterNesnesi: ViewToPresenterAnasayfaProtocol?
    
    let userID = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
            
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumLineSpacing = 5
        tasarim.minimumInteritemSpacing = 5
        let genislik = self.yemeklerCollectionView.frame.size.width
        let hucreGenislik = (genislik - 30) / 3
        tasarim.itemSize = CGSize(width: hucreGenislik, height: hucreGenislik)
        yemeklerCollectionView.collectionViewLayout = tasarim
        
        AnasayfaRouter.createModule(ref: self)
        
        anasayfaPresenterNesnesi?.yemekleriYukle()
        
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.adresYukle(userID: userID!)
        badgeKontrol()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            let yemek = sender as? Yemekler
            let gidilecekVC = segue.destination as! YemekDetayVC
            gidilecekVC.yemek = yemek
        }
    }
    
    @IBAction func addressChangeClicked(_ sender: Any) {
        anasayfaPresenterNesnesi?.adresGuncelle(userID: userID!, adres: deliveryAddressTF.text!)
        makeAlert(title: "BAŞARILI!", message: "Teslimat Adresi Başarıyla Değiştirildi.")
    }
    
   
    @IBAction func segmentedClicked(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            yemeklerListesi = tempYemeklerListesi
        }
        if sender.selectedSegmentIndex == 2{
            yemeklerListesi = tempYemeklerListesi
            var temp = [Yemekler]()
            temp.append(yemeklerListesi[0])
            temp.append(yemeklerListesi[2])
            temp.append(yemeklerListesi[6])
            temp.append(yemeklerListesi[11])
            yemeklerListesi = temp
        }
        if sender.selectedSegmentIndex == 1{
            yemeklerListesi = tempYemeklerListesi
            yemeklerListesi.remove(at: 0)
            yemeklerListesi.remove(at: 1)
            yemeklerListesi.remove(at: 4)
            yemeklerListesi.remove(at: 8)
        }
        DispatchQueue.main.async {
            self.yemeklerCollectionView.reloadData()
        }
    }
    
    
    
}

extension AnasayfaVC: PresenterToViewAnasayfaProtocol{
    func viewaYemekGonder(yemeklerListesi: Array<Yemekler>) {
        self.yemeklerListesi = yemeklerListesi
        self.tempYemeklerListesi = yemeklerListesi
        self.yemeklerCollectionView.reloadData()
    }
    func viewaAdresGonder(adres: String) {
        deliveryAddressTF.text = adres
    }
}

extension AnasayfaVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemeklerListesi[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! YemeklerCollectionViewCell
        
        cell.yemekAdiLabel.text = yemek.yemek_adi
        cell.yemekFiyatLabel.text = "\(yemek.yemek_fiyat!)₺"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi ?? "kofte.png")"){
            DispatchQueue.main.async {
                cell.hucreResim.kf.setImage(with: url)
            }
        }
        /*cell.hucreLabel.text = kategori.kisim
        cell.hucreResim.image = UIImage(named: kategori.kresim!)*/
        
        /*cell.layer.borderColor = UIColor.orange.cgColor
        cell.layer.borderWidth = 0.2
        cell.layer.cornerRadius = 10*/
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek = yemeklerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: yemek)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
