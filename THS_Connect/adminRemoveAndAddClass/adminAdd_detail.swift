//
//  adminAdd_detail.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/6/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase

class adminAdd_detail: UIViewController {
    
    @IBOutlet weak var dcl: UILabel!
  
    @IBOutlet weak var teacher: UILabel!
    
    @IBOutlet weak var rn: UILabel!

    var passedID: String!
    var receivedClassName: String!
    var receivedTeacher: String!
    var receiveRoomNumber: String!
    var receiveClassID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
dcl.text? = receivedClassName
    teacher.text? = receivedTeacher
        rn.text? = receiveRoomNumber
        // Do any additional setup after loading the view.
    }
    //adds class to user
    @IBAction func AddClass(_ sender: Any) {
        let student_name = UserDefaults.standard.string(forKey: "studentName")! ?? ""
        print(student_name)
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            let student = snapshot.childSnapshot(forPath: "User_info/studentID").value as? String
            print(student)
            if(student == student_name){
                let user_uid = snapshot.childSnapshot(forPath: "User_info/uid").value as? String
                let b = Database.database().reference().child("Users").child(user_uid!).child("Classes").child(self.receiveClassID)
                print(b)
                b.setValue(self.receiveClassID)
                let c = Database.database().reference().child("Classes").child(self.receiveClassID).child("Students").child(user_uid!)
                c.setValue(user_uid,withCompletionBlock: {(error, c) in
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

})
}
}
