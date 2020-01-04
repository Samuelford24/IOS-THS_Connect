//
//  Home.swift
//  THS_Connect
//
//  Created by Samuel Ford on 5/24/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

    class class_custom_cell2: UITableViewCell {
      
        
        
        
        @IBOutlet weak var cc: UILabel!
        
        @IBOutlet weak var teacher: UILabel!
        @IBOutlet weak var rn: UILabel!
        
        @IBOutlet weak var id: UILabel!
        
        
}
       
class Home: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var classes2 = [Class]()
    var keys = [String]()
    var pass1: String!
    var pass2: String!
    var pass3: String!
    var pass4: String!
    @IBOutlet weak var tb_Yourclasses: UITableView!
    
       // var passedValue: String!
        override func viewDidLoad() {
            super.viewDidLoad()
           
          // tb_yourClasses.delegate = self
        //    tb_yourClasses.dataSource = self
            //self.tableView.rowHeight = 80;
           //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style:
            //   tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
            
       fetchClass2()
            
            
        }
        
    func fetchClass2(){
  let userID = Auth.auth().currentUser!.uid

        print(userID)
        
        Database.database().reference().child("Users").child(userID).child("Classes").observe(.childAdded, with: { (snapshot) in
   print("1",snapshot)
            //print(userID)
            //need to get the child"class_info" from firebase
             let class_id = snapshot.value as? String
        print("2",class_id)
                
            Database.database().reference().child("Classes").child(class_id!).child("class_info").observe(DataEventType.value, with: { (snapshot) in
                if(snapshot.exists()){
                    print("2.5",snapshot)
                let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                
                  //   let dictionary2 = snapshot as? [String: AnyObject]
                print("3", postDict)
                    let class_object = Class(dictionary: postDict)
                        self.classes2.append(class_object)
                        //self.classes.append(class_object)
                        
                        //this will crash because of background thread, so lets use dispatch_async to fix
                }
                else{ let ref = Database.database().reference().child("Users").child(userID).child("Classes").child(class_id!)
                    ref.removeValue()
                }
                DispatchQueue.main.async(execute: {
                            self.tb_Yourclasses.reloadData()
                    
            
                        })
                    
                    
                }, withCancel: nil)
                
            
      
        }, withCancel: nil)
        Database.database().reference().child("Users").child(userID).child("Classes").observe(.childRemoved, with: { (snapshot) in
            let id = snapshot.value as? String
            for i in 0..<self.classes2.count {
                if (id == self.classes2[i].class_id) {
                    DispatchQueue.main.async(execute: {
                        self.classes2.remove(at: i)
                        self.tb_Yourclasses.reloadData()
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! class_custom_cell2
            
            let data_class2 = classes2[indexPath.row]
        print(data_class2)
            cell.cc?.text = data_class2.date_clasname
            cell.teacher?.text = data_class2.teacher
            cell.rn?.text = data_class2.room_number
        cell.id?.text = data_class2.class_id
            
            return cell
        }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   NSLog("You selected cell number: \(indexPath.row)!")
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! class_custom_cell2
        pass1 = currentCell.cc.text
        
        pass2 = currentCell.teacher.text
        pass3 = currentCell.rn.text
        pass4 = currentCell.id.text
        // passID = currentCell.class_id.text
        
        performSegue(withIdentifier: "remove_detail", sender: self)
        
        //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="remove_detail") {
            let viewController = segue.destination as! removeClassDetail
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
