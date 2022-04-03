//
//  YemekSiparisProtocols.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 3.04.2022.
//

import Foundation

protocol ViewToPresenterYemekSiparisProtocol{
    var yemekSiparisInteractor: PresenterToInteractorYemekSiparisProtocol? {get set}
    var yemekSiparisView: PresenterToViewYemekSiparisProtocol? {get set}
    
    func siparislerYukle(userID: String)
}

protocol PresenterToInteractorYemekSiparisProtocol{
    var yemekSiparisPresenter: InteractorToPresenterYemekSiparisProtocol? {get set}
    
    func siparislerYukle(userID: String)
}

protocol InteractorToPresenterYemekSiparisProtocol{
    func presenteraVeriGonder(siparislerListesi: Array<Siparisler>)
}

protocol PresenterToViewYemekSiparisProtocol{
    func viewaVeriGonder(siparislerListesi: Array<Siparisler>)
}

protocol PresenterToRouterYemekSiparisProtocol{
    static func createModule(ref: SiparislerVC)
}
