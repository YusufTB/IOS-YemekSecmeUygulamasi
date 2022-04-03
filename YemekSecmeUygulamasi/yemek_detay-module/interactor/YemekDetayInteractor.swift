//
//  YemekDetayInteractor.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation
import Alamofire

class YemekDetayInteractor: PresenterToInteractorYemekDetayProtocol{
    func sepeteYemekEkle(userID: String, yemekAdi: String, yemekAdet: String, yemekFiyat: String, yemekResimAdi: String) {
        let params: Parameters = ["yemek_adi": yemekAdi, "yemek_resim_adi": yemekResimAdi, "yemek_fiyat": yemekFiyat,"kullanici_adi": userID, "yemek_siparis_adet": yemekAdet ]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
