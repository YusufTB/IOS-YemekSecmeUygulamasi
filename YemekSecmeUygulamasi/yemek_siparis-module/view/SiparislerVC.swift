//
//  SiparislerVC.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 1.04.2022.
//

import UIKit
import Firebase

class SiparislerVC: UIViewController {

    let userID = Auth.auth().currentUser?.uid
    
    var siparislerListesi = [Siparisler]()
    @IBOutlet weak var siparislerTableView: UITableView!
    
    var yemekSiparisPresenterNesnesi: ViewToPresenterYemekSiparisProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        siparislerTableView.delegate = self
        siparislerTableView.dataSource = self
        
        YemekSiparisRouter.createModule(ref: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        yemekSiparisPresenterNesnesi?.siparislerYukle(userID: userID!)
    }
}

extension SiparislerVC: PresenterToViewYemekSiparisProtocol{
    func viewaVeriGonder(siparislerListesi: Array<Siparisler>) {
        self.siparislerListesi = siparislerListesi
        siparislerTableView.reloadData()
    }
}

extension SiparislerVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siparislerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let siparis = siparislerListesi[indexPath.row]
        
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "siparisHucre", for: indexPath) as! SiparislerTableViewCell
        
        hucre.siparisLabel.text = "\(siparis.siparis_tarih!) tarihinde \(siparis.siparis_adet!) adet ürün \(siparis.siparis_tutar!)₺ ile sipariş verilmiştir."
        
        return hucre
    }
}
