//
//  AnasayfaPresenter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

class AnasayfaPresenter: ViewToPresenterAnasayfaProtocol{
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriYukle() {
        anasayfaInteractor?.tumYemekleriYukle()
    }
    func adresYukle(userID: String) {
        anasayfaInteractor?.adresYukle(userID: userID)
    }
    func adresGuncelle(userID: String, adres: String) {
        anasayfaInteractor?.kullaniciAdresGuncelle(userID: userID, adres: adres)
    }
}

extension AnasayfaPresenter: InteractorToPresenterAnasayfaProtocol{
    func presenteraYemekGonder(yemeklerListesi: Array<Yemekler>) {
        anasayfaView?.viewaYemekGonder(yemeklerListesi: yemeklerListesi)
    }
    func presenteraAdresGonder(adres: String) {
        anasayfaView?.viewaAdresGonder(adres: adres)
    }
}
