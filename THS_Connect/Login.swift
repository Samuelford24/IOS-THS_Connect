//
//  Login.swift
//  THS_Connect
//
//  Created by Samuel Ford on 5/23/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Login: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil && Auth.auth().currentUser!.isEmailVerified {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // if Auth.auth().currentUser != nil {
         //   let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab")
           // self.present(vc!, animated: true, completion: nil)
            
        
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func DismissKeyboard()  {
        view.endEditing(true)
    }
    
    
    @IBAction func login(_ sender: Any) {
        if self.email.text == "" || self.password.text == ""  {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
           // || self.password.text!.count <= 6
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                   
                   if (Auth.auth().currentUser!.isEmailVerified == false){
                      let ac = UIAlertController(title: "Your Email is not verified", message: "Would you like the email verification email resent?", preferredStyle: UIAlertController.Style.alert)
                         let OKaction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                            Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                            ac.dismiss(animated: true, completion: nil)
                         })
                         let NOaction = UIAlertAction(title:"No", style: UIAlertAction.Style.default, handler:{ action in
                             ac.dismiss(animated: false, completion: nil)               })
                         
                         
                         
                         ac.addAction(OKaction)
                         ac.addAction(NOaction)
                    self.present(ac, animated: true, completion: nil)
                        }
                    //Print into the console if successfully logged in
                    
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab")
                    self.present(vc!, animated: true, completion: nil)
                    
                }
            
        else {
                    
                    }
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            func hideKeyboard(){
              email.resignFirstResponder()
                password.resignFirstResponder()
            }
            func textFieldShouldReturn( textField: UITextField) -> Bool{
                print("Return pressed")
                hideKeyboard()
               return true
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

