//
//  Register2VC.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 29.03.2022.
//

import UIKit
import Firebase

class Register2VC: UIViewController {

    @IBOutlet weak var isimTF: UITextField!
    @IBOutlet weak var adresTF: UITextField!
    
    var ref = Database.database().reference().child("kisiler")
    
    var id = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func kaydetClicked(_ sender: Any) {

}
