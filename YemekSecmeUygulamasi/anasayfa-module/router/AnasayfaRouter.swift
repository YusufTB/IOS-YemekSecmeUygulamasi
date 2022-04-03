//
//  AnasayfaRouter.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 2.04.2022.
//

import Foundation

class AnasayfaRouter: PresenterToRouterAnasayfaProtocol{
    static func createModule(ref: AnasayfaVC) {
        let presenter = AnasayfaPresenter()
        
        //View
        ref.anasayfaPresenterNesnesi = presenter
        //Presenter
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor = AnasayfaInteractor()
        ref.anasayfaPresenterNesnesi?.anasayfaView = ref
        //Interactor
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor?.anasayfaPresenter = presenter
    }
}
