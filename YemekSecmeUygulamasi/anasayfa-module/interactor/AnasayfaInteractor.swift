//
//  AnasayfaInteractor.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation
import Alamofire
import Firebase

class AnasayfaInteractor: PresenterToInteractorAnasayfaProtocol{
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    init(){
        
    }
    
    func tumYemekleriYukle() {
        var yemeklerListesi = [Yemekler]()
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response{ response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let gelenListe = cevap.yemekler{
                        yemeklerListesi = gelenListe
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            self.anasayfaPresenter?.presenteraYemekGonder(yemeklerListesi: yemeklerListesi)
        }
    }
    
    func kullaniciAdresGuncelle(userID: String, adres: String) {
        let ref = Database.database().reference().child("kisiler")
        ref.child(userID).updateChildValues(["kisi_adres": adres])
    }
    
    func adresYukle(userID: String) {
        let ref = Database.database().reference().child("kisiler")
        ref.child(userID).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let gelenAdres = value?["kisi_adres"] as? String ?? ""
            self.anasayfaPresenter?.presenteraAdresGonder(adres: gelenAdres)
            // ...
        }) { error in
            print(error.localizedDescription)
        }
    }
}
