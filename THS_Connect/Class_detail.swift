//
//  Class_detail.swift
//  THS_Connect
//
//  Created by Samuel Ford on 7/8/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Class_detail: UIViewController {
    var receivedClassName: String!
      var receivedTeacher: String!
      var receiveRoomNumber: String!
    var receiveClassID: String!
    @IBOutlet weak var label_DCL: UILabel!
    @IBOutlet weak var label_Teacher: UILabel!
    @IBOutlet weak var label_roomNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
label_DCL.text? = receivedClassName
        label_Teacher.text? = receivedTeacher
        label_roomNumber.text? = receiveRoomNumber
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
    
    @IBAction func addClass(_ sender: Any) {
        let b = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("Classes").child(receiveClassID)
        print(b)
        b.setValue(receiveClassID)
        let c = Database.database().reference().child("Classes").child(receiveClassID).child("Students").child(Auth.auth().currentUser!.uid)
        c.setValue(Auth.auth().currentUser!.uid,withCompletionBlock: {(error, c) in
            if error != nil {
                let ac = UIAlertController(title: "Class could not be added! Check your wifi/data connection.", message:nil, preferredStyle: UIAlertController.Style.alert)
                let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    ac.dismiss(animated: true, completion: nil)               })
                
                
                
                ac.addAction(OKaction)
                self.present(ac, animated: true, completion: nil)
                
                
            } else {
                
                let ac = UIAlertController(title: "Class Added ", message:nil, preferredStyle: UIAlertController.Style.alert)
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
