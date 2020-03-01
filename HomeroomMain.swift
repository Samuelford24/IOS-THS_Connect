//
//  HomeroomMain.swift
//  THS_Connect
//
//  Created by Samuel Ford on 2/28/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class customHMAIN: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var studentid: UILabel!
    @IBOutlet weak var uid: UILabel!
    
}
class HomeroomMain: UIViewController, UITableViewDelegate, UITableViewDataSource {
var uidtobePassed: String!
var name: String!
  
    var Users = [User]()

    @IBOutlet weak var tbHR: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("HR").observe(.value, with: { (snapshot) in
            if(!snapshot.exists()){
                print("DOESNT EXIST")
                let ac = UIAlertController(title: "You do not have access to this page ", message:"This page is meant for teachers only; login to the admin panel to enable access if you are a teacher. The data on this page will load once access if enabled.", preferredStyle: UIAlertController.Style.alert)
                      let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                        
                       
                        
                          ac.dismiss(animated: true, completion: nil)
                       
                      })
                      
                      
                      
                      ac.addAction(OKaction)
                self.present(ac, animated: true, completion: nil)
            }
            else{
                self.loadHomeroom()
            }
        })
    }
    func loadHomeroom(){
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("HR").observe(.value, with: { (snapshot) in
           let s = snapshot.value as? String
            let  b = Database.database().reference().child(s!)
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
                                                self.tbHR.reloadData()
                                              })
                                              
                                              
                                          }, withCancel: nil)
                                          
                                          
                                          
                                      }, withCancel: nil)
                                          
                                  
                                      
                                  })
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
                               let cell = tableView.dequeueReusableCell(withIdentifier: "hr", for: indexPath)
                               as! customHMAIN
                              let student = Users[indexPath.row]
                        
                               cell.name?.text = student.name
                               cell.grade?.text = student.grade
                               cell.studentid?.text = student.studentID
                    cell.uid.text = student.uid
                    uidtobePassed=student.uid
                    name=student.name
                               return cell
                           }
            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                           let indexPath = tableView.indexPathForSelectedRow!
                              let currentCell = tableView.cellForRow(at: indexPath)! as! customHMAIN               //NEED TO ADD UID AND GET IT FOR ATTENDANCE AND VIEWING STUDENTS CLASSES.
                let ac = UIAlertController(title: "View " + name + "'s Attendance or Classes", message: nil, preferredStyle: UIAlertController.Style.alert)
                     let OKaction = UIAlertAction(title: "Check Attendance", style: UIAlertAction.Style.default, handler: { action in
                        
                        self.performSegue(withIdentifier: "attendance2", sender: nil)
                     })
                     let NOaction = UIAlertAction(title:"View Classes", style: UIAlertAction.Style.default, handler:{ action in
                         self.performSegue(withIdentifier: "classes2", sender: nil)
                        
                        
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
                                 if (segue.identifier=="attendance2") {
                                     var viewController = segue.destination as! Attendance
                                    
                                    viewController.uid = uidtobePassed
                                }
                                    if(segue.identifier=="classes2"){
                                       var viewController2 = segue.destination as! StudentsClasses
                                        viewController2.uid=uidtobePassed
                                    }
}
}
                                    

