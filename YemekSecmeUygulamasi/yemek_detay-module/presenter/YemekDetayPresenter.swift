//
//  YemekDetayPresenter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

class YemekDetayPresenter: ViewToPresenterYemekDetayProtocol{
    var yemekDetayInteractor: PresenterToInteractorYemekDetayProtocol?
    
    func sepeteYemekEkle(userID: String, yemekAdi: String, yemekAdet: String, yemekFiyat: String, yemekResimAdi: String) {
        yemekDetayInteractor?.sepeteYemekEkle(userID: userID, yemekAdi: yemekAdi, yemekAdet: yemekAdet, yemekFiyat: yemekFiyat, yemekResimAdi: yemekResimAdi)
    }
}
