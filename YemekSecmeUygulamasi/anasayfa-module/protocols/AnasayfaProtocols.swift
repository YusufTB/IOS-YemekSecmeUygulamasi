//
//  AnasayfaProtocols.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

protocol ViewToPresenterAnasayfaProtocol{ // Presenter
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView: PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle()
    func adresYukle(userID: String)
    func adresGuncelle(userID: String, adres: String)
}

protocol PresenterToInteractorAnasayfaProtocol{ // Interactor
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumYemekleriYukle()
    func adresYukle(userID: String)
    func kullaniciAdresGuncelle(userID: String, adres: String)
}

protocol InteractorToPresenterAnasayfaProtocol{
    func presenteraYemekGonder(yemeklerListesi: Array<Yemekler>)
    func presenteraAdresGonder(adres: String)
}

protocol PresenterToViewAnasayfaProtocol{
    func viewaYemekGonder(yemeklerListesi: Array<Yemekler>)
    func viewaAdresGonder(adres: String)
}

protocol PresenterToRouterAnasayfaProtocol{
    static func createModule(ref: AnasayfaVC)
}
