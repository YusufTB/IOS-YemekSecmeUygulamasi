//
//  YemekSiparisPresenter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 3.04.2022.
//

import Foundation

class YemekSiparisPresenter: ViewToPresenterYemekSiparisProtocol{
    var yemekSiparisInteractor: PresenterToInteractorYemekSiparisProtocol?
    var yemekSiparisView: PresenterToViewYemekSiparisProtocol?
    
    func siparislerYukle(userID: String) {
        yemekSiparisInteractor?.siparislerYukle(userID: userID)
    }
}

extension YemekSiparisPresenter: InteractorToPresenterYemekSiparisProtocol{
    func presenteraVeriGonder(siparislerListesi: Array<Siparisler>) {
        yemekSiparisView?.viewaVeriGonder(siparislerListesi: siparislerListesi)
    }
}
