//
//  Siparisler.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 1.04.2022.
//

import Foundation

class Siparisler{
    var siparis_adet: String?
    var siparis_tarih: String?
    var siparis_tutar: String?
    
    init(){
        
    }
    
    init(siparis_adet: String, siparis_tarih: String, siparis_tutar: String){
        self.siparis_adet = siparis_adet
        self.siparis_tarih = siparis_tarih
        self.siparis_tutar = siparis_tutar
    }
}
