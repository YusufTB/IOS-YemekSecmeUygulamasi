//
//  DenemeVC.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 28.03.2022.
//

import UIKit
import Kingfisher
import Alamofire
import Firebase

class YemekDetayVC: UIViewController {

    var yemek: Yemekler?
    var yemekDetayPresenterNesnesi: ViewToPresenterYemekDetayProtocol?
    
    @IBOutlet weak var yemekDetayImageView: UIImageView!
    @IBOutlet weak var yemekDetayIsımLabel: UILabel!
    @IBOutlet weak var yemekDetayFiyatLabel: UILabel!
    @IBOutlet weak var yemekDetayAdetLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let y = yemek{
            yemekDetayIsımLabel.text = y.yemek_adi
            yemekDetayFiyatLabel.text = "\(y.yemek_fiyat!) ₺"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi ?? "kofte.png")"){
                DispatchQueue.main.async {
                    self.yemekDetayImageView.kf.setImage(with: url)
                }
            }
        }
        YemekDetayRouter.createModule(ref: self)
        setupNavigationBar()
    }
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        yemekDetayAdetLabel.text = "\(String(Int(sender.value))) ADET"
    }
    
    @IBAction func sepeteYemekEkleClicked(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        let yemekAdi = yemek!.yemek_adi!
        let yemekAdet = Int(stepper.value)
        let yemekFiyat = Int(yemek!.yemek_fiyat!)! * yemekAdet
        let yemekResimAdi = yemek!.yemek_resim_adi!
        yemekDetayPresenterNesnesi?.sepeteYemekEkle(userID: userID!, yemekAdi: yemekAdi, yemekAdet: String(yemekAdet), yemekFiyat: String(yemekFiyat), yemekResimAdi: yemekResimAdi)
        badgeKontrol()
        makeAlert(title: "BAŞARILI", message: "Yemek Başarıyla Sepete Eklendi.")
    }
    
}
