//
//  YourInfo.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/14/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class YourInfo: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var studentIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchUserInfo()
        
    }
    func fetchUserInfo(){
        let userID = Auth.auth().currentUser!.uid
        
Database.database().reference().child("Users").child(userID).child("User_info").observe(DataEventType.value, with: { (snapshot) in
    let name = snapshot.childSnapshot(forPath: "name").value as? String
    //print(name)
    let email = snapshot.childSnapshot(forPath: "email").value as? String
  //  print(email)
    let Loading="Loading..."
    let grade = snapshot.childSnapshot(forPath: "grade").value as? String
    let studentID = snapshot.childSnapshot(forPath: "studentID").value as? String
    self.nameLabel.text? = name ?? Loading
    self.emailLabel.text? = email ?? Loading
    self.gradeLabel.text? = grade ?? Loading
    self.studentIDLabel.text? = studentID ?? Loading
})

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
