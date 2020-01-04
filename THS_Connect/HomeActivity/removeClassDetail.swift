//
//  removeClassDetail.swift
//  THS_Connect
//
//  Created by Samuel Ford on 7/29/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class removeClassDetail: UIViewController {
    var receivedClassName: String!
    var receivedTeacher: String!
    var receiveRoomNumber: String!
    var receiveClassID: String!
    
    @IBOutlet weak var cc: UILabel!
    @IBOutlet weak var t: UILabel!
    @IBOutlet weak var R: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
cc.text? = receivedClassName
        t.text? = receivedTeacher
        R.text? = receiveRoomNumber
        // Do any additional setup after loading the view.
        let ref = Database.database().reference().child("Toggle_Classes")
               ref.observeSingleEvent(of: .value, with: { (snapshot) in
               // Do any additional setup after loading the view.
                  if let dictionary = snapshot.value as? String {
                   print(dictionary)
                       if (dictionary=="Classes Closed"){
                          
                       let ac = UIAlertController(title: "Classes are Closed", message:nil, preferredStyle: UIAlertController.Style.alert)
                              let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                                  ac.dismiss(animated: true, completion: nil)
                               self.navigationController?.popViewController(animated: true)
                             })
                              
                              
                              
                              ac.addAction(OKaction)
                          self.present(ac, animated: true, completion: nil)
                       
                   }
    }
        })
    }
    @IBAction func removeClass(_ sender: Any) {
        let uid = Auth.auth().currentUser!.uid
        let myRef = Database.database().reference().child("Users").child(uid).child("Classes").child(receiveClassID)
        myRef.removeValue()
        
        let myRef2 = Database.database().reference().child("Classes").child(receiveClassID).child("Students").child(uid)
        myRef2.removeValue (completionBlock: {(error, myRef2) in
            if error != nil {
                let ac = UIAlertController(title: "Class could not be removed! Check your wifi/data connection.", message:nil, preferredStyle: UIAlertController.Style.alert)
                let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    ac.dismiss(animated: true, completion: nil)               })
                
                
                
                ac.addAction(OKaction)
                self.present(ac, animated: true, completion: nil)
                
                
            } else {
          
                let ac = UIAlertController(title: "Class Removed ", message:nil, preferredStyle: UIAlertController.Style.alert)
                let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    ac.dismiss(animated: true, completion: nil)               })
                
                
                
                ac.addAction(OKaction)
               self.present(ac, animated: true, completion: nil)
                
            }
            })
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
