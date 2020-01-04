//
//  adminDeleteClass_detail.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/3/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class adminDeleteClass_detail: UIViewController {
    var recievedID: String!
    var receivedClassName: String!
    var receivedTeacher: String!
    var receivedRoomNumber: String!
    
    
    
    @IBOutlet weak var dCL5: UILabel!
    @IBOutlet weak var t5: UILabel!
    @IBOutlet weak var rn5: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
dCL5.text? = receivedClassName
        t5.text? = receivedTeacher
        rn5.text? = receivedRoomNumber
        // Do any additional setup after loading the view.
    }
    @IBAction func removeClass5(_ sender: Any) {
       let ref = Database.database().reference(
        ).child("Classes").child(recievedID)
        ref.removeValue(completionBlock: {(error, ref) in
            if error != nil {
                let ac = UIAlertController(title: "Class could not be deleted! Check your wifi/data connection.", message:nil, preferredStyle: UIAlertController.Style.alert)
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
