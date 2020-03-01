//
//  StudentsClasses.swift
//  THS_Connect
//
//  Created by Samuel Ford on 2/23/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class cellStudent: UITableViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var room: UILabel!
    
    
}
class StudentsClasses: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var studentsClasses: UITableView!
    var uid: String!
    var classes2 = [Class]()
    override func viewDidLoad() {
        super.viewDidLoad()
print("StudentsClasses", uid)
     getClasses()
                   }
                   func getClasses(){
                     Database.database().reference().child("Users").child(uid).child("Classes").observe(.childAdded, with: { (snapshot) in
                        
                                    let class_id = snapshot.value as? String
                        Database.database().reference().child("Classes").child(class_id!).child("class_info").observe(DataEventType.value, with: { (snapshot) in
                                       if(snapshot.exists()){
                                         
                                       let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                                       
                                         //   let dictionary2 = snapshot as? [String: AnyObject]
                                     
                                           let class_object = Class(dictionary: postDict)
                                               self.classes2.append(class_object)
                                               //self.classes.append(class_object)
                                               
                                               //this will crash because of background thread, so lets use dispatch_async to fix
                                       }
                                       else{ let ref = Database.database().reference().child("Users").child(self.uid).child("Classes").child(class_id!)
                                           ref.removeValue()
                                       }
                                       DispatchQueue.main.async(execute: {
                                        self.studentsClasses.reloadData()
                                           
                                   
                                               })
                                           
                                           
                                       }, withCancel: nil)
                                       
                                   
                             
                               }, withCancel: nil)
                               Database.database().reference().child("Users").child(uid).child("Classes").observe(.childRemoved, with: { (snapshot) in
                                   let id = snapshot.value as? String
                                   for i in 0..<self.classes2.count {
                                       if (id == self.classes2[i].class_id) {
                                           DispatchQueue.main.async(execute: {
                                               self.classes2.remove(at: i)
                                               self.studentsClasses.reloadData()
                                           })
                                           return
                                       }
                                   }
                               })
                               
                               
                           }
                           
                                   

                               
                               @objc func handleCancel() {
                                   dismiss(animated: true, completion: nil)
                               }
                               
                               func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                                   //print(classes2)
                                   return classes2.count
                                   
                               }
                               
                              func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                                   
                                   // let use a hack for now, we actually need to dequeue our cells for memory efficiency
                                   //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
                                   
                                   let cell = tableView.dequeueReusableCell(withIdentifier: "classes", for: indexPath) as! cellStudent
                                   
                                   let data_class2 = classes2[indexPath.row]
                               print(data_class2)
                                   cell.Name?.text = data_class2.date_clasname
                                   cell.teacher?.text = data_class2.teacher
                                   cell.room?.text = data_class2.room_number
                            //   cell.id?.text = data_class2.class_id
                                   
                                   return cell
                               }
                            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                               //   NSLog("You selected cell number: \(indexPath.row)!")
                               let indexPath = tableView.indexPathForSelectedRow!
                             
                           }
                          

}





                       
