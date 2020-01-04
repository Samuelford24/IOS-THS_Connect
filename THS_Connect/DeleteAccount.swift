//
//  DeleteAccount.swift
//  THS_Connect
//
//  Created by Samuel Ford on 1/2/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class DeleteAccount: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func DeleteAccount(_ sender: Any) {
        if(email.text=="" || password.text==""){
            showAlertMessage(title: "Error", message: "Enter an email and password to delete account")
            return
        }
        //let credential: AuthCredential
         let user = Auth.auth().currentUser
        //let ref=Database.database().reference().child("Users").child(user!.uid)
      //  ref.removeValue()
   
        var credential: AuthCredential = EmailAuthProvider.credential(withEmail: email.text!, password: password.text!)

        // Prompt the user to re-provide their sign-in credentials
        let ref=Database.database().reference().child("Users").child(user!.uid)
        ref.removeValue()
        user?.reauthenticate(with: credential) { error in
          if let error = error {
            // An error happened.
            self.showAlertMessage(title: "Error Deleting Account", message: "Please make sure you enterd your correct email and password!")
          } else {
            let ref=Database.database().reference().child("Users").child(user!.uid)
            ref.removeValue(completionBlock: { (error, ref) in
            user?.delete{ error in
            if let error = error {
              // An error happened.
                self.showAlertMessage(title: "Error Deleting Account", message: "Please check your connection and try again!")
            } else {
                self.performSegue(withIdentifier: "toLogin", sender: nil)
               
                 }

                        }
                     })
            }
            
        }
    }
            /*
             }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



    func showAlertMessage(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
