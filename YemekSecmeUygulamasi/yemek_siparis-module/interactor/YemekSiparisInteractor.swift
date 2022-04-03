//
//  YemekSiparisInteractor.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 3.04.2022.
//

import Foundation
import Firebase

class YemekSiparisInteractor: PresenterToInteractorYemekSiparisProtocol{
    var yemekSiparisPresenter: InteractorToPresenterYemekSiparisProtocol?
    
    func siparislerYukle(userID: String) {
        var siparislerListesi = [Siparisler]()
        
        siparislerListesi.removeAll()
        let ref = Database.database().reference().child("siparisler")
        ref.child(userID).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            if let value = snapshot.value as? NSDictionary{
                let keys = value.allKeys
                let count = keys.count
                for i in 0..<count{
                    let gelenSatir = value[keys[i]] as? NSDictionary
                    let gelenTutar = gelenSatir!["siparis_tutar"] as! String
                    let gelenAdet = gelenSatir!["siparis_adet"] as! String
                    let gelenTarih = gelenSatir!["siparis_tarih"] as! String
                    let siparis = Siparisler(siparis_adet: gelenAdet, siparis_tarih: gelenTarih, siparis_tutar: gelenTutar)
                    siparislerListesi.append(siparis)
                }
            }
            self.yemekSiparisPresenter?.presenteraVeriGonder(siparislerListesi: siparislerListesi)
        }){ error in
            print(error.localizedDescription)
        }
    }
}
