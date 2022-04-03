//
//  YemekSepetPresenter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

class YemekSepetPresenter: ViewToPresenterYemekSepetProtocol{
    var yemekSepetInteractor: PresenterToInteractorYemekSepetProcotol?
    var yemekSepetView: PresenterToViewYemekSepetProtocol?
    
    func sepettekiYemekleriGetir(userID: String) {
        yemekSepetInteractor?.sepettekiYemekleriGetir(userID: userID)
    }
    func sepettekiYemegiSil(userID: String, sepetYemekID: Int) {
        yemekSepetInteractor?.sepettekiYemegiSil(userID: userID, sepetYemekID: sepetYemekID)
    }
    func siparisiTamamla(userID: String, adet: String, tutar: String, siparisTarih: String, sepetUrunlerListesi: Array<SepetYemekler>) {
        yemekSepetInteractor?.siparisiTamamla(userID: userID, adet: adet, tutar: tutar, siparisTarih: siparisTarih, sepetUrunlerListesi: sepetUrunlerListesi)
    }
}

extension YemekSepetPresenter: InteractorToPresenterYemekSepetProtocol{
    func presenteraSepettekiYemekleriGonder(sepetYemeklerListesi: Array<SepetYemekler>) {
        yemekSepetView?.viewaSepettekiYemekleriGonder(sepetYemeklerListesi: sepetYemeklerListesi)
    }
}
