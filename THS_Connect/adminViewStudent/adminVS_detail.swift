
//
//  adminVS_detail.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/2/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class custom_user_cell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    
    @IBOutlet weak var uid: UILabel!
    @IBOutlet weak var studentID: UILabel!
}
class adminVS_detail: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tb_adminVS_detail: UITableView!
    
    var Users = [User]()
    var receivedID: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("ID", receivedID!)
        // Do any additional setup after loading the view.
        fetchStudent()
    }
    func fetchStudent()  {
       let b = Database.database().reference().child("Classes").child(receivedID!).child("Students")
        b.observe(.childAdded, with: { (snapshot) in
            print("ref", b)
            //print(userID)
            //need to get the child"class_info" from firebase
            let student_id = snapshot.value as? String
            
            print("2",student_id)
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
                    self.tb_adminVS_detail.reloadData()
                })
                
                
            }, withCancel: nil)
            
            
            
        }, withCancel: nil)
            
    
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return Users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "adminVS_detail_cell", for: indexPath) as! custom_user_cell
        let student = Users[indexPath.row]
        print(student)
        cell.name?.text = student.name
        cell.grade?.text = student.grade
        cell.studentID?.text = student.studentID
        cell.uid?.text = student.uid
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //   NSLog("You selected cell number: \(indexPath.row)!")
           let indexPath = tableView.indexPathForSelectedRow!
        print(indexPath)
           let currentCell = tableView.cellForRow(at: indexPath)! as! custom_user_cell
        let uid = currentCell.uid.text!
        let ac = UIAlertController(title: "What would you like to do?", message:nil, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Mark Student Absent", style: UIAlertAction.Style.default, handler: { action in
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd.yyyy"
            let result = formatter.string(from: date)
            print(result)
             let ref = Database.database().reference()
            let fr = ref.child("Users").child(uid).child("Attendance")
            print(fr)
            let gdf=fr.childByAutoId().key
            print(gdf)
            fr.child(gdf).setValue("Absent from assigned class on: " + result)
            self.Users.remove(at: indexPath.row)
                         tableView.deselectRow(at: indexPath, animated: true)
                         self.tb_adminVS_detail.reloadData()
            
        })
               let OKaction = UIAlertAction(title: "Remove Student", style: UIAlertAction.Style.default, handler: { action in
                let ref = Database.database().reference()
                let d = ref.child("Classes").child(self.receivedID).child("Students").child(uid)
                print(d)
                d.removeValue()
               let f = ref.child("Users").child(uid).child("Classes").child(self.receivedID)
                //print(f)
                f.removeValue()
                //let int = self.Users[indexPath.row]
                self.Users.remove(at: indexPath.row)
                tableView.deselectRow(at: indexPath, animated: true)
                self.tb_adminVS_detail.reloadData()
               })
        let NOaction = UIAlertAction(title:"Cancel", style: UIAlertAction.Style.default, handler:{ action in
            ac.dismiss(animated: true, completion: nil)               })
        
               
               
        ac.addAction(NOaction)
               ac.addAction(OKaction)
        ac.addAction(action)
               present(ac, animated: true, completion: nil)
           }
    
           // passID = currentCell.class_id.text
           
           //performSegue(withIdentifier: "remove_detail", sender: self)
    func relodData() {
        self.tb_adminVS_detail.reloadData()
    }
           //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


