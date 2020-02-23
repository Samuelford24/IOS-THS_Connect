//
//  StudentsInHomeroom.swift
//  THS_Connect
//
//  Created by Samuel Ford on 1/28/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class customUserCell: UITableViewCell {
  
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var studentID: UILabel!
    
}
class StudentsInHomeroom: UITableViewController {
    var teacher2: String!
    var hrRefToPass: String!
     var Users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
             getStudents()
            }
            func getStudents(){
                print(teacher2!)
                print(hrRefToPass)
                let  b = Database.database().reference().child(hrRefToPass).child(teacher2)
                b.observe(.childAdded, with: { (snapshot) in
                    print(snapshot.key)
                     let student_id = snapshot.value as? String
                               
               
                    Database.database().reference().child("Users").child(student_id!).child("User_info").observe(DataEventType.value, with: { (snapshot) in
                    if(!snapshot.exists()){
                        b.child(student_id!).removeValue()
                        
                        
                    }
                 let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                               
                               //   let dictionary2 = snapshot as? [String: AnyObject]
                               print("3", postDict)
                               let user_object = User(dictionary: postDict)
                               self.Users.append(user_object)
                               //self.classes.append(class_object)
                               
                               //this will crash because of background thread,  use dispatch_async to fix
                               DispatchQueue.main.async(execute: {
                                   self.tableView.reloadData()
                               })
                               
                               
                           }, withCancel: nil)
                           
                           
                           
                       }, withCancel: nil)
                           
                   
                       
                   }
            // MARK: - Table view data source

            override func numberOfSections(in tableView: UITableView) -> Int {
                // #warning Incomplete implementation, return the number of sections
                return 1
            }

            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return Users.count
            }

           
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
                as! customUserCell
               let student = Users[indexPath.row]
         
                cell.name?.text = student.name
                cell.grade?.text = student.grade
                cell.studentID?.text = student.studentID
        
                return cell
            }
             override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let indexPath = tableView.indexPathForSelectedRow!
               let currentCell = tableView.cellForRow(at: indexPath)! as! customUserCell                //NEED TO ADD UID AND GET IT FOR ATTENDANCE AND VIEWING STUDENTS CLASSES.
              
            }
           
        }
