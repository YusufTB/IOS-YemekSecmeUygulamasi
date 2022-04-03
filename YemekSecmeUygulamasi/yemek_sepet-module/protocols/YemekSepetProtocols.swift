//
//  YemekSepetProtocols.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

protocol ViewToPresenterYemekSepetProtocol{
    var yemekSepetInteractor: PresenterToInteractorYemekSepetProcotol? {get set}
    var yemekSepetView: PresenterToViewYemekSepetProtocol? {get set}
    
    func sepettekiYemekleriGetir(userID: String)
    func sepettekiYemegiSil(userID: String, sepetYemekID: Int)
    func siparisiTamamla(userID: String, adet: String, tutar: String, siparisTarih: String, sepetUrunlerListesi: Array<SepetYemekler>)
}

protocol PresenterToInteractorYemekSepetProcotol{
    var yemekSepetPresenter: InteractorToPresenterYemekSepetProtocol? {get set}
    
    func sepettekiYemekleriGetir(userID: String)
    func sepettekiYemegiSil(userID: String, sepetYemekID: Int)
    func siparisiTamamla(userID: String, adet: String, tutar: String, siparisTarih: String, sepetUrunlerListesi: Array<SepetYemekler>)
}

protocol InteractorToPresenterYemekSepetProtocol{
    func presenteraSepettekiYemekleriGonder(sepetYemeklerListesi: Array<SepetYemekler>)
}

protocol PresenterToViewYemekSepetProtocol{
    func viewaSepettekiYemekleriGonder(sepetYemeklerListesi: Array<SepetYemekler>)
}

protocol PresenterToRouterYemekSepetProtocol{
    static func createModule(ref: SepetimVC)
}
