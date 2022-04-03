//
//  Extensions.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 29.03.2022.
//

import UIKit
import Firebase
import Alamofire

extension UIViewController{
     
    func setupNavigationBar(){
        self.navigationItem.title = "Yemek Seçmece"
        
        let appearance = UINavigationBarAppearance()
        //Arkaplan rengi
        appearance.backgroundColor = UIColor(named: "anaRenk")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.font: UIFont(name: "Hurricane-Regular", size: 40)!]
//        let navController = navigationController!
//
//        let image = UIImage(named: "yemekSecmeceLogo") //Your logo url here
//        let imageView = UIImageView(image: image)
//
//        let bannerWidth = navController.navigationBar.frame.size.width
//        let bannerHeight = navController.navigationBar.frame.size.height
//
//        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
//        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
//
//        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
//        imageView.contentMode = .scaleAspectFit
//
//        navigationItem.titleView = imageView
       
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "userLogo"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(fbButtonPressed), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        //RGB renk paletine göre arkaplanı yükler
        navigationController?.navigationBar.isTranslucent = true
        //Status bar rengi değişimi
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc func fbButtonPressed(){
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("kisiler").child(uid!).observeSingleEvent(of: .value, with: { snapshot in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let gelenIsim = value?["kisi_isim"] as? String ?? ""
            let gelenEmail = value?["kisi_email"] as? String ?? ""
            
            let alert = UIAlertController(title: "Merhaba \(gelenIsim)", message: "\(gelenEmail)", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let cancelButton = UIAlertAction(title: "ÇIKIŞ", style: UIAlertAction.Style.destructive) { UIAlertAction in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error")
                }
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            }
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
            
            // ...
        }) { error in
            print(error.localizedDescription)
        }
        
        
        
        /*ref.observe(.value, with: { snapshot in
            if let gelenVeri = snapshot.value as? [String: AnyObject]{
                for satir in gelenVeri{
                    if let d = satir.value as? NSDictionary{
                        if satir.key == uid!{
                            let gelenİsim = d["kisi_isim"] as? String ?? ""
                            let gelenEmail = d["kisi_email"] as? String ?? ""
                            
                            let alert = UIAlertController(title: "Merhaba \(gelenİsim)", message: "\(gelenEmail)", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                            let cancelButton = UIAlertAction(title: "ÇIKIŞ", style: UIAlertAction.Style.destructive) { UIAlertAction in
                                do{
                                    try Auth.auth().signOut()
                                }catch{
                                    print("Error")
                                }
                                self.performSegue(withIdentifier: "toLogin", sender: nil)
                            }
                            alert.addAction(okButton)
                            alert.addAction(cancelButton)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                }
            }
        })*/

    }
    
    func badgeKontrol(){
        var count = 0
        let userID = Auth.auth().currentUser?.uid
        let params: Parameters = ["kullanici_adi": userID!]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response{ response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                        if let sepetYemekler = json["sepet_yemekler"] as? [[String:Any]]{
                            for _ in sepetYemekler{
                                count += 1
                            }
                        }
                        
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            if let tabItems = self.tabBarController?.tabBar.items{
                let sepetTabBarItem = tabItems[1]
                sepetTabBarItem.badgeValue = String(count)
            }
        }
    }
    
    func makeAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Tamam", style: .default)
        alertController.addAction(tamamAction)
        self.present(alertController, animated: true )
    }
}
