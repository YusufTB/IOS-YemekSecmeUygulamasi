//
//  SepetimVC.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 31.03.2022.
//

import UIKit
import Firebase
import Alamofire
import Kingfisher

class SepetimVC: UIViewController {

    var sepetUrunlerListesi = [SepetYemekler]()
    let userID = Auth.auth().currentUser?.uid
    
    var yemekSepetPresenterNesnesi: ViewToPresenterYemekSepetProtocol?
    
    @IBOutlet weak var sepetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        
        sepetTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        YemekSepetRouter.createModule(ref: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        yemekSepetPresenterNesnesi?.sepettekiYemekleriGetir(userID: userID!)
        badgeKontrol()
    }
    
    @IBAction func siparisiTamamlaClicked(_ sender: Any) {
        
        if sepetUrunlerListesi.isEmpty == true{
            makeAlert(title: "Sepetiniz Boş", message: "Siparişi Tamamlayamazsınız!")
            return
        }
        
        var adet = 0
        var tutar = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = Date()
        dateFormatter.locale = Locale(identifier: "tr_TR")
        
        for urun in sepetUrunlerListesi{
            adet += Int(urun.yemek_siparis_adet!)!
            tutar += Int(urun.yemek_fiyat!)!
        }
        
        let siparisTarih = String(dateFormatter.string(from: date))
        let strAdet = String(adet)
        let strTutar = String(tutar)
        
        
        self.yemekSepetPresenterNesnesi?.siparisiTamamla(userID: self.userID!, adet: strAdet, tutar: strTutar, siparisTarih: siparisTarih, sepetUrunlerListesi: self.sepetUrunlerListesi)
        
        makeAlert(title: "BAŞARILI", message: "Siparişiniz başarıyla tamamlandı.")
    }
    

}

extension SepetimVC: PresenterToViewYemekSepetProtocol{
    func viewaSepettekiYemekleriGonder(sepetYemeklerListesi: Array<SepetYemekler>) {
        self.sepetUrunlerListesi = sepetYemeklerListesi
        self.badgeKontrol()
        self.sepetTableView.reloadData()
    }
}

extension SepetimVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetUrunlerListesi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sepet = sepetUrunlerListesi[indexPath.row]
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "sepetHucre", for: indexPath) as! SepetTableViewCell
        
        hucre.sepetUrunIsımLabel.text = sepet.yemek_adi
        hucre.sepetUrunTutarLabel.text = "\(sepet.yemek_fiyat!) ₺"
        hucre.sepetUrunAdetLabel.text = "\(sepet.yemek_siparis_adet!) Adet"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(sepet.yemek_resim_adi ?? "kofte.png")"){
            DispatchQueue.main.async {
                hucre.sepetUrunResimImageView.kf.setImage(with: url)
            }
        }
        return hucre
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (ca, v, b) in
            let yemekSepetID = Int(self.sepetUrunlerListesi[indexPath.row].sepet_yemek_id!)!
            self.yemekSepetPresenterNesnesi?.sepettekiYemegiSil(userID: self.userID!, sepetYemekID: yemekSepetID)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
