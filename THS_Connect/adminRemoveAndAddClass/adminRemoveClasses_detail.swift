//
//  adminRemoveClasses_detail.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/5/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase

class adminRemoveClasses_detail: UIViewController {
    var receivedClassName: String!
    var receivedTeacher: String!
    var receiveRoomNumber: String!
    var receiveClassID: String!
    
    @IBOutlet weak var dcl: UILabel!

    @IBOutlet weak var t: UILabel!
    
    @IBOutlet weak var rn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dcl.text? = receivedClassName
        t.text? = receivedTeacher
        rn.text? = receiveRoomNumber
        // Do any additional setup after loading the view.
    }
    @IBAction func remove_class(_ sender: Any) {
        let uid = UserDefaults.standard.string(forKey: "user_id")! ?? ""
        print(uid)

     let myRef = Database.database().reference().child("Users").child(uid).child("Classes").child(receiveClassID)
 myRef.removeValue()
 
 let myRef2 = Database.database().reference().child("Classes").child(receiveClassID).child("Students").child(uid)
        myRef2.removeValue(completionBlock: {(error, myRef2) in
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
