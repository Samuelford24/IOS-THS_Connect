//
//  admin_add_classViewController.swift
//  THS_Connect
//
//  Created by Samuel Ford on 6/15/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class admin_add_classViewController: UIViewController {
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var date_classname: UITextField!
    @IBOutlet weak var teacher: UITextField!
    @IBOutlet weak var room_number: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let Tap:UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func DismissKeyboard()  {
        view.endEditing(true)
    }
    
    @IBAction func add_class(_ sender: Any) {
      //  self.subject.text!
       // Class( date_classname.text!, teacher.text)
        let ref = Database.database().reference()
         let subject2 = subject.text!
        
        if subject2 == "Science" || subject2 == "Math" || subject2 == "Social Studies" || subject2 == "English" || subject2 == "Other" || subject2 == "Technology"{
        //self.subject.text! ==
        //"Math", self.subject.text! == "Social Studies", self.subject.text! == "English", self.subject.text! == "Other", self.subject.text! == "Technology"

        
        
           let ref = ref.child("Classes").childByAutoId()
           // let  key = ref.child(subject2).childByAutoId()
          // dref.setValue( )
          // let post_key = key
            ref.setValue(nil)
            let c = ref.key
            print(c)
            let values = ["date_clasname": self.date_classname.text, "teacher": self.teacher.text, "subject": self.subject.text, "room_number": self.room_number.text, "uid": c] as [String : Any]
            
            
            ref.child("class_info").setValue(values)
            let ac = UIAlertController(title: "Class Added ", message:nil, preferredStyle: UIAlertController.Style.alert)
            let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                ac.dismiss(animated: true, completion: nil)               })
            
            
            
            ac.addAction(OKaction)
            present(ac, animated: true, completion: nil)
            
         //  let c = dref.key
         //   print(c)
        }
        else {
            let ac = UIAlertController(title: "Error ", message:nil, preferredStyle: UIAlertController.Style.alert)
            let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                ac.dismiss(animated: true, completion: nil)               })
            
            
            
            ac.addAction(OKaction)
            present(ac, animated: true, completion: nil)
            
                
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


