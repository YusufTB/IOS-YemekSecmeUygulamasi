//
//  YemekDetayRouter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

class YemekDetayRouter: PresenterToRouterYemekDetayProtocol{
    static func createModule(ref: YemekDetayVC) {
        ref.yemekDetayPresenterNesnesi = YemekDetayPresenter()
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor = YemekDetayInteractor()
    }
}
