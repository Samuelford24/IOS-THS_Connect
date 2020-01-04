//
//  adminVS_classes.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/2/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase

class class_custom_cell3: UITableViewCell {
    @IBOutlet weak var c3: UILabel!
    
    @IBOutlet weak var t3: UILabel!
    
    @IBOutlet weak var rn3: UILabel!
    @IBOutlet weak var id3: UILabel!
}
class adminVS_classes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passID: String!
  
    var passedValue: String!
    var classes3 = [Class]()
    @IBOutlet weak var tb_adminVS3: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchClass2()
    }
    func fetchClass2() {
        // guard let uid = ?.user.uid
        // else{return}
        //let userID = Auth.auth().currentUser!.uid
        
        Database.database().reference().child("Classes").queryOrdered(byChild: "class_info/subject").queryEqual(toValue : passedValue).observe(.childAdded, with: { (snapshot) in
            //print(userID)
            //need to get the child"class_info" from firebase
            if let dictionary = snapshot.childSnapshot(forPath: "class_info").value as? [String: AnyObject] {
                let class_object = Class(dictionary: dictionary)
                self.classes3.append(class_object)
                print(snapshot)
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                   self.tb_adminVS3.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return classes3.count
    }
    var idOfClass: String!
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! class_custom_cell3
        
        let data_class = classes3[indexPath.row]
        cell.c3?.text = data_class.date_clasname
        cell.t3?.text = data_class.teacher
        cell.rn3?.text = data_class.room_number
        cell.id3?.text = data_class.class_id
        
        
        return cell
    }
    
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   NSLog("You selected cell number: \(indexPath.row)!")
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! class_custom_cell3
     //   passDCL = currentCell.date_classname.text
     //   print(passDCL)
      //  passTeacher = currentCell.teacher.text//
      //  passID = currentCell.class_id.text
         passID = currentCell.id3.text
        
        performSegue(withIdentifier: "adminVS_detail", sender: self)
        
        //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="adminVS_detail") {
            let viewController = segue.destination as! adminVS_detail
          //  viewController.receivedClassName = passDCL
          //  viewController.receivedTeacher = passTeacher
            
          //  viewController.receiveRoomNumber = passRN
          //  viewController.receiveClassID = passID
            viewController.receivedID = passID
            
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
