//
//  YemekSepetRouter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

class YemekSepetRouter: PresenterToRouterYemekSepetProtocol{
    static func createModule(ref: SepetimVC) {
        let presenter = YemekSepetPresenter()
        
        ref.yemekSepetPresenterNesnesi = presenter
        
        ref.yemekSepetPresenterNesnesi?.yemekSepetInteractor = YemekSepetInteractor()
        ref.yemekSepetPresenterNesnesi?.yemekSepetView = ref
        
        ref.yemekSepetPresenterNesnesi?.yemekSepetInteractor?.yemekSepetPresenter = presenter
    }
}
