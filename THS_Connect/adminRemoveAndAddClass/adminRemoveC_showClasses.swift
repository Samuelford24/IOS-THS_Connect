//
//  adminRemoveC_showClasses.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/3/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class customCell_Classes22: UITableViewCell{
    
    @IBOutlet weak var arc1: UILabel!
    @IBOutlet weak var arc2: UILabel!
    @IBOutlet weak var arc3: UILabel!
    @IBOutlet weak var arcuid: UILabel!
    
}
class adminRemoveC_showClasses: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passedValue: String!
    var passID: String!
    var classes5 = [Class]()
    var pass1: String!
    var pass2: String!
    var pass3: String!
    var pass4: String!
    @IBOutlet weak var tb5: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        findStudentandShowClasses()
    }
    func findStudentandShowClasses() {
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            let student = snapshot.childSnapshot(forPath: "User_info/studentID").value as? String
            print(student)
            if(student == self.passedValue!){
                let user_uid = snapshot.childSnapshot(forPath: "User_info/uid").value as? String
                print(user_uid)
                UserDefaults.standard.set(user_uid!, forKey: "user_id")
                
                print("userREF",user_uid)
                
                Database.database().reference().child("Users").child(user_uid!).child("Classes").observe(.childAdded, with: { (snapshot) in
                    let classRef = snapshot.value as? String
                    
                  
                    Database.database().reference().child("Classes").child(classRef!).child("class_info").observe(DataEventType.value, with: {(snapshot)   in
                        let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                  
                        //   let dictionary2 = snapshot as? [String: AnyObject]
                        print("3", postDict)
                        let class_object = Class(dictionary: postDict)
                        self.classes5.append(class_object)
                        DispatchQueue.main.async(execute: {
                            self.tb5.reloadData()
                            
                            
                        })
                        
                    }, withCancel: nil)
                }, withCancel: nil)
           
            }
            
    })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return classes5.count
    }
    var idOfClass: String!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell22", for: indexPath) as! customCell_Classes22
        
        let data_class = classes5[indexPath.row]
        print("data",data_class)
        cell.arc1?.text = data_class.date_clasname
        cell.arc2?.text = data_class.teacher
        cell.arc3?.text = data_class.room_number
        cell.arcuid?.text = data_class.class_id
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   NSLog("You selected cell number: \(indexPath.row)!")
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! customCell_Classes22
        pass1 = currentCell.arc1.text
        
        pass2 = currentCell.arc2.text
        pass3 = currentCell.arc3.text
        pass4 = currentCell.arcuid.text
        // passID = currentCell.class_id.text
        
        performSegue(withIdentifier: "admin_remove_detail", sender: self)
        
        //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="admin_remove_detail") {
            let viewController = segue.destination as! adminRemoveClasses_detail
            viewController.receivedClassName = pass1
            viewController.receivedTeacher = pass2
            
            viewController.receiveRoomNumber = pass3
            viewController.receiveClassID = pass4
            //viewController.receiveClassID = passID
            
            //  }
            
            //}
        }
    }
    
    
    
    
    
    
    
}
