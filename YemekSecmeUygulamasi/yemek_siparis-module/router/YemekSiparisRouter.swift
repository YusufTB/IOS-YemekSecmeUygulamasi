//
//  YemekSiparisRouter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 3.04.2022.
//

import Foundation

class YemekSiparisRouter: PresenterToRouterYemekSiparisProtocol{
    static func createModule(ref: SiparislerVC) {
        
        let presenter = YemekSiparisPresenter()
        
        ref.yemekSiparisPresenterNesnesi = presenter
        
        ref.yemekSiparisPresenterNesnesi?.yemekSiparisInteractor = YemekSiparisInteractor()
        ref.yemekSiparisPresenterNesnesi?.yemekSiparisView = ref
        
        ref.yemekSiparisPresenterNesnesi?.yemekSiparisInteractor?.yemekSiparisPresenter = presenter
    }
}
