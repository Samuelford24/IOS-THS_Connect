//
//  adminAdd_subjects.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/6/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class customAddCell: UITableViewCell {
    @IBOutlet weak var dcl6: UILabel!
    @IBOutlet weak var t6: UILabel!
    
    @IBOutlet weak var rn6: UILabel!
    @IBOutlet weak var id6: UILabel!
    
}
class adminAdd_subjects: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    var passedValue: String!
    var passID: String!
    var pass1: String!
    var pass2: String!
    var pass3: String!
    var pass4: String!
    @IBOutlet weak var tb_Add: UITableView!
    var classes6 = [Class]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchClass6()
    }
    func fetchClass6() {
        // guard let uid = ?.user.uid
        // else{return}
        //let userID = Auth.auth().currentUser!.uid
        
        Database.database().reference().child("Classes").queryOrdered(byChild: "class_info/subject").queryEqual(toValue : passedValue).observe(.childAdded, with: { (snapshot) in
            //print(userID)
            //need to get the child"class_info" from firebase
            if let dictionary = snapshot.childSnapshot(forPath: "class_info").value as? [String: AnyObject] {
                let class_object = Class(dictionary: dictionary)
                self.classes6.append(class_object)
                print(snapshot)
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.tb_Add.reloadData()
                })
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return classes6.count
    }
    var idOfClass: String!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAddCell", for: indexPath) as! customAddCell
        
        let data_class = classes6[indexPath.row]
        cell.dcl6?.text = data_class.date_clasname
        cell.t6?.text = data_class.teacher
        cell.rn6?.text = data_class.room_number
        cell.id6?.text = data_class.class_id
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   NSLog("You selected cell number: \(indexPath.row)!")
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! customAddCell
        //   passDCL = currentCell.date_classname.text
        //   print(passDCL)
        //  passTeacher = currentCell.teacher.text//
        //  passID = currentCell.class_id.text
        pass1 = currentCell.dcl6.text
        
        pass2 = currentCell.t6.text
        pass3 = currentCell.rn6.text
        pass4 = currentCell.id6.text
      
        
        performSegue(withIdentifier: "adminAddDetail", sender: self)
        
        //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="adminAddDetail") {
            let viewController = segue.destination as! adminAdd_detail
             viewController.receivedClassName = pass1
              viewController.receivedTeacher = pass2
            
           viewController.receiveRoomNumber = pass3
              viewController.receiveClassID = pass4
           //viewController.receivedID = passID
            
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
