//
//  YemekDetayProtocols.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

protocol ViewToPresenterYemekDetayProtocol{
    var yemekDetayInteractor: PresenterToInteractorYemekDetayProtocol? {get set}
    
    func sepeteYemekEkle(userID: String, yemekAdi: String, yemekAdet: String, yemekFiyat: String, yemekResimAdi: String)
}

protocol PresenterToInteractorYemekDetayProtocol{
    func sepeteYemekEkle(userID: String, yemekAdi: String, yemekAdet: String, yemekFiyat: String, yemekResimAdi: String)
}

protocol PresenterToRouterYemekDetayProtocol{
    static func createModule(ref: YemekDetayVC)
}
