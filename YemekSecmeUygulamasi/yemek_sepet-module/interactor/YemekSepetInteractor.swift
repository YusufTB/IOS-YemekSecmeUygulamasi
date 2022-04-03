//
//  YemekSepetInteractor.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation
import Alamofire
import UIKit
import Firebase

class YemekSepetInteractor: PresenterToInteractorYemekSepetProcotol{
    var yemekSepetPresenter: InteractorToPresenterYemekSepetProtocol?
    
    func sepettekiYemekleriGetir(userID: String) {
        var sepetUrunlerListesi = [SepetYemekler]()
        
        let params: Parameters = ["kullanici_adi": userID]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        if let sepetYemekler = json["sepet_yemekler"] as? [[String:Any]]{
                            for i in sepetYemekler{
                                let syemekId = i["sepet_yemek_id"]! as! String
                                let syemekAdi = i["yemek_adi"]! as! String
                                let syemekResimAdi = i["yemek_resim_adi"]! as! String
                                let syemekFiyat = i["yemek_fiyat"]! as! String
                                let syemekSiparisAdet = i["yemek_siparis_adet"]! as! String
                                let skullaniciAdi = i["kullanici_adi"]! as! String
                                let sepetYemek = SepetYemekler(sepet_yemek_id: syemekId, yemek_adi: syemekAdi, yemek_resim_adi: syemekResimAdi, yemek_fiyat: syemekFiyat, yemek_siparis_adet: syemekSiparisAdet, kullanici_adi: skullaniciAdi)
                                    sepetUrunlerListesi.append(sepetYemek)
                            }
                        }
                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
//            if sepettekiYemekler.count == 0{
//                print("sepet boş")
//            }else{
//                for i in sepettekiYemekler{
//                    print(i.yemek_adi!)
//                }
//            }
            self.yemekSepetPresenter?.presenteraSepettekiYemekleriGonder(sepetYemeklerListesi: sepetUrunlerListesi)
        }
    }
    func sepettekiYemegiSil(userID: String, sepetYemekID: Int) {
        let params: Parameters = ["sepet_yemek_id": sepetYemekID, "kullanici_adi": userID]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            self.sepettekiYemekleriGetir(userID: userID)
        }
    }
    func siparisiTamamla(userID: String, adet: String, tutar: String, siparisTarih: String, sepetUrunlerListesi: Array<SepetYemekler>) {
        let ref = Database.database().reference().child("siparisler")
        let yeniSiparis = ["siparis_adet": adet, "siparis_tarih": siparisTarih, "siparis_tutar": tutar]
        ref.child(userID).childByAutoId().setValue(yeniSiparis)
        
        for i in 0..<sepetUrunlerListesi.count{
            let params: Parameters = ["sepet_yemek_id": Int(sepetUrunlerListesi[i].sepet_yemek_id!)!, "kullanici_adi": userID]
            
            AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: params).response{ response in
                if let data = response.data{
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                            print(json)
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
                self.sepettekiYemekleriGetir(userID: userID)
            }
        }
    }
    
}
