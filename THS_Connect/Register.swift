//
//  Register.swift
//  THS_Connect
//
//  Created by Samuel Ford on 5/23/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit


import Firebase
import FirebaseAuth
import FirebaseDatabase


class Register: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var grade: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var homeroom: UITextField!
    let h1 = UInt8(65)
    let h2 = UInt8(67)
    let h3 = UInt8(70)
    let h4 = UInt8(76)
    let h5 = UInt8(79)
    let h6 = UInt8(83)
    let h7 = UInt8(90)
    var hr=""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let Tap:UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func DismissKeyboard()  {
        view.endEditing(true)
    }
    @IBAction func registeruser(_ sender: Any) {
        if self.email.text == "", self.password.text!.count <= 6, self.grade.text == "", self.name.text == "" ,
            self.studentID.text == "", self.homeroom.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Please make sure that all information is correct, you entered a valid email, and your password is greater than 6 characters", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
             
                    guard let uid = user?.user.uid else {
                        return
                    }
                    var hr2 = self.homeroom.text!
                    hr2=hr2.uppercased()
                    let h =  hr2.prefix(1)
                    let c = String(h)
                   let value = Character(c).asciiValue
                    print(value)
                  //  someUIntToInt = Int(value)
                    if(value! >= self.h1 && value! < self.h2){
                        self.hr="HR1"
                    }
                    else if(value! <= self.h3){
                        self.hr="HR2"
                    }
                    else if(value! <= self.h4){
                        self.hr="HR3"
                    }

                    else if(value! <= self.h5){
                        self.hr="HR4"
                    }

                    else if(value! <= self.h6){
                        self.hr="HR5"
                    }
                    else if(value! <= self.h7){
                        self.hr="HR6"
                    }
                    else{
                        self.hr="Incorrect Format"
                    }
                    print(self.hr)
                    let ref3 = Database.database().reference().child(self.hr).child(hr2).child(uid)
                    print(ref3)
                    ref3.setValue(uid)

                    
                
                 
                    Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                    let ref = Database.database().reference()
                    let usersReference = ref.child("Users").child(uid).child("User_info")
                    let values = ["email": self.email.text!, "name": self.name.text!, "grade": self.grade.text!,"studentID":self.studentID.text!, "uid": Auth.auth().currentUser!.uid]
                    usersReference.setValue(values) {
                    (error:Error?, ref:DatabaseReference) in
                    if error != nil {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                                    
                                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    alertController.addAction(defaultAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)
                   
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                }
                        else{
                        Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                         let ac = UIAlertController(title: "Registered Successfully ", message: "A verification email has been sent to your email", preferredStyle: UIAlertController.Style.alert)
                              let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
                                                   self.present(vc!, animated: true, completion: nil)
                                ac.dismiss(animated: true, completion: nil)
                              })
                             
                              
                              
                              
                              ac.addAction(OKaction)
                              
                        self.present(ac, animated: true, completion: nil)
                                           
                        }
                        
                    }
                }
                    else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
            }
        }
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



