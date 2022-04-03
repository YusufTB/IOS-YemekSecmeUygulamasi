//
//  RegisterVC.swift
//  YemekSecmeUygulamasi
//
//  Created by yusufmac on 28.03.2022.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    
    var ref = Database.database().reference().child("kisiler")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func registerClicked(_ sender: Any) {
        if emailTF.text != "" && passwordTF.text != ""{
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { authdata, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toAnasayfa", sender: nil)
                    self.createUser()
                }
            }
        }else{
           makeAlert(titleInput: "Error!", messageInput: "Username/Password")
        }
    }
    
    func createUser(){
        if let userID = Auth.auth().currentUser?.uid{
            let newPerson = ["kisi_id": userID, "kisi_isim": nameTF.text!, "kisi_adres": addressTF.text!, "kisi_email": emailTF.text!]
            self.ref.child(userID).setValue(newPerson)
        }else{
            makeAlert(titleInput: "Error", messageInput: "Error!")
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
