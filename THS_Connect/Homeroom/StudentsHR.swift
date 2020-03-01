//
//  StudentsHR.swift
//  THS_Connect
//
//  Created by Samuel Ford on 2/22/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
 class customUserCell2: UITableViewCell {
    @IBOutlet weak var NAME: UILabel!
    
    @IBOutlet weak var GRADE: UILabel!
    
    @IBOutlet weak var STUDENTID: UILabel!
    
    @IBOutlet weak var UID: UILabel!
}

class StudentsHR: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var uidtobePassed: String!
    var name: String!
       var teacher2: String!
       var hrRefToPass: String!
        var Users = [User]()
    @IBOutlet weak var TV: UITableView!
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
                                    self.TV.reloadData()
                                  })
                                  
                                  
                              }, withCancel: nil)
                              
                              
                              
                          }, withCancel: nil)
                              
                      
                          
                      }
               // MARK: - Table view data source

  func numberOfSections(in tableView: UITableView) -> Int {
                   // #warning Incomplete implementation, return the number of sections
                   return 1
               }

            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                   // #warning Incomplete implementation, return the number of rows
                   return Users.count
               }

              
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
                   as! customUserCell2
                  let student = Users[indexPath.row]
            
                   cell.NAME?.text = student.name
                   cell.GRADE?.text = student.grade
                   cell.STUDENTID?.text = student.studentID
        cell.UID?.text = student.uid
        uidtobePassed=student.uid
        name=student.name
                   return cell
               }
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               let indexPath = tableView.indexPathForSelectedRow!
                  let currentCell = tableView.cellForRow(at: indexPath)! as! customUserCell2                //NEED TO ADD UID AND GET IT FOR ATTENDANCE AND VIEWING STUDENTS CLASSES.
    let ac = UIAlertController(title: "View " + name + "'s Attendance or Classes", message: nil, preferredStyle: UIAlertController.Style.alert)
         let OKaction = UIAlertAction(title: "Check Attendance", style: UIAlertAction.Style.default, handler: { action in
            
            self.performSegue(withIdentifier: "attendance", sender: nil)
         })
         let NOaction = UIAlertAction(title:"View Classes", style: UIAlertAction.Style.default, handler:{ action in
             self.performSegue(withIdentifier: "classes", sender: nil)
            
            
         })
    let Cancelaction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
                ac.dismiss(animated: false, completion: nil)
    tableView.deselectRow(at: indexPath, animated: true)
            })
         
         
         
         ac.addAction(OKaction)
         ac.addAction(NOaction)
    ac.addAction(Cancelaction)
         present(ac, animated: true, completion: nil)
         
              
                 }
                 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                     if (segue.identifier=="attendance") {
                         var viewController = segue.destination as! Attendance
                        
                        viewController.uid = uidtobePassed
                    }
                        if(segue.identifier=="classes"){
                           var viewController2 = segue.destination as! StudentsClasses
                            viewController2.uid=uidtobePassed
                        }
                        
                    
                     // Get the new view controller using segue.destination.
                     // Pass the selected object to the new view controller.
                 }
              
           }

