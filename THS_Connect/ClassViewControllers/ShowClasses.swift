//
//  classes_test_TableViewController.swift
//  THS_Connect
//
//  Created by Samuel Ford on 6/11/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
//import  FirebaseDatabase
import  Firebase

class class_custom_cell: UITableViewCell {
    
    @IBOutlet weak var date_classname: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var room_number: UILabel!
    @IBOutlet weak var class_id: UILabel!
}

class Science_classes: UITableViewController {
    //let cellId = "cellId"
    var passedValue: String!
    //var valueToPass: String!
    var classes = [Class]()
    var passDCL: String!
    var passTeacher: String!
    var passRN: String!
    var passID: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.rowHeight = 80;
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style:
     //   tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchClass()
    }
    
    func fetchClass() {
       // guard let uid = ?.user.uid
           // else{return}
        //let userID = Auth.auth().currentUser!.uid
   
        Database.database().reference().child("Classes").queryOrdered(byChild: "class_info/subject").queryEqual(toValue : passedValue).observe(.childAdded, with: { (snapshot) in
            //print(userID)
            //need to get the child"class_info" from firebase
            if let dictionary = snapshot.childSnapshot(forPath: "class_info").value as? [String: AnyObject] {
                let class_object = Class(dictionary: dictionary)
                self.classes.append(class_object)
                print(snapshot)
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    var idOfClass: String!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_class", for: indexPath) as! class_custom_cell
        
        let data_class = classes[indexPath.row]
        cell.date_classname?.text = data_class.date_clasname
        cell.teacher?.text = data_class.teacher
        cell.room_number?.text = data_class.room_number
     cell.class_id?.text = data_class.class_id
        
      
        return cell
    }
    
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   NSLog("You selected cell number: \(indexPath.row)!")
    let indexPath = tableView.indexPathForSelectedRow!
    let currentCell = tableView.cellForRow(at: indexPath)! as! class_custom_cell
    passDCL = currentCell.date_classname.text
    print(passDCL)
    passTeacher = currentCell.teacher.text
    passRN = currentCell.room_number.text
    passID = currentCell.class_id.text
   // passID = currentCell.class_id.text
  
    performSegue(withIdentifier: "class_detail", sender: self)
    
    //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier=="class_detail") {
        let viewController = segue.destination as! Class_detail
           viewController.receivedClassName = passDCL
        viewController.receivedTeacher = passTeacher
       
        viewController.receiveRoomNumber = passRN
        viewController.receiveClassID = passID
        //viewController.receiveClassID = passID
            
      //  }
        
    //}
}
/*
class UserCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
*/
}
}
