//
//  ViewController.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 28.03.2022.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


    @IBAction func signInClicked(_ sender: Any) {
        if emailTF.text != "" && passwordTF.text != ""{
            
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { authdata, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toAnasayfa", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput: "Error!", messageInput: "Email/Password")
        }
    }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

