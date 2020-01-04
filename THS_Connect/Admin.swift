//
//  Admin.swift
//  THS_Connect
//
//  Created by Samuel Ford on 5/24/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Admin: UIViewController {
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let Tap:UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func DismissKeyboard()  {
        view.endEditing(true)
    }
    
    
    @IBAction func submit(_ sender: Any) {
        Database.database().reference().child("Password").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? String {
           //  print(dictionary)
                if (self.password.text! == dictionary){
                   // NSLog("Login Successfully...")
                    self.performSegue(withIdentifier: "admin_panel", sender: self)
                }
                else{
                    let ac = UIAlertController(title: "Incorrect Password ", message:nil, preferredStyle: UIAlertController.Style.alert)
                           let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                               ac.dismiss(animated: true, completion: nil)               })
                           
                           
                           
                           ac.addAction(OKaction)
                    self.present(ac, animated: true, completion: nil)
                       }
                }
                
            
            
            
        
            
            
            
        
        
            
           /* let ac = UIAlertController(title: "Login Failed!!", message: nil, preferredStyle: UIAlertController.Style.alert)
            let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                self.dismiss(animated: true, completion: nil)
                
            })
            ac.addAction(OKaction)
            present(ac, animated: true, completion: nil)*/
        
        
    }, withCancel: nil)
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "admin_panel" {
            if let destination = segue.destination as? Admin {
               // destination.nomb = nombres // you can pass value to destination view controller
                
                // destination.nomb = arrayNombers[(sender as! UIButton).tag] // Using button Tag
            }
        }
    }
}
