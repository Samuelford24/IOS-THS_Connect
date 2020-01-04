//
//  adminDeleteClass_classes.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/3/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import  Firebase
class customDeleteCell: UITableViewCell {
    
   
    @IBOutlet weak var cd4: UILabel!
    
    @IBOutlet weak var t4: UILabel!
    
    @IBOutlet weak var rn4: UILabel!
    @IBOutlet weak var id4: UILabel!
}
class adminDeleteClass_classes: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var passDCL: String!
    var passTeacher: String!
    var passRN:String!

    
    
    var passedValue: String!
    var passID: String!
      var classes4 = [Class]()
    @IBOutlet weak var tb_deleteClasses: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchClasses()
    }
    func fetchClasses() {

        Database.database().reference().child("Classes").queryOrdered(byChild: "class_info/subject").queryEqual(toValue : passedValue).observe(.childAdded, with: { (snapshot) in
    //print(userID)
    //need to get the child"class_info" from firebase
    if let dictionary = snapshot.childSnapshot(forPath: "class_info").value as? [String: AnyObject] {
    let class_object = Class(dictionary: dictionary)
    self.classes4.append(class_object)
    print(snapshot)
    //this will crash because of background thread, so lets use dispatch_async to fix
    DispatchQueue.main.async(execute: {
    self.tb_deleteClasses.reloadData()
    })
    }
    
    }, withCancel: nil)
}

@objc func handleCancel() {
    dismiss(animated: true, completion: nil)
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return classes4.count
}
var idOfClass: String!
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // let use a hack for now, we actually need to dequeue our cells for memory efficiency
    //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! customDeleteCell
    
    let data_class = classes4[indexPath.row]
    cell.cd4?.text = data_class.date_clasname
    cell.t4?.text = data_class.teacher
    cell.rn4?.text = data_class.room_number
    cell.id4?.text = data_class.class_id
    
    
    return cell
}


func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //   NSLog("You selected cell number: \(indexPath.row)!")
    let indexPath = tableView.indexPathForSelectedRow!
    let currentCell = tableView.cellForRow(at: indexPath)! as! customDeleteCell
    //   passDCL = currentCell.date_classname.text
    //   print(passDCL)
    //  passTeacher = currentCell.teacher.text//
    //  passID = currentCell.class_id.text
    passDCL = currentCell.cd4.text
    //print(passDCL)
    passTeacher = currentCell.t4.text
    passRN = currentCell.rn4.text
    passID = currentCell.id4.text
    
    performSegue(withIdentifier: "adminDelete_detail", sender: self)
    
    //self.performSegue(withIdentifier: "yourIdentifier", sender: self)
}
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier=="adminDelete_detail") {
        let viewController = segue.destination as! adminDeleteClass_detail
          viewController.receivedClassName = passDCL
          viewController.receivedTeacher = passTeacher
        viewController.receivedRoomNumber = passRN
        //  viewController.receiveClassID = passID
        viewController.recievedID = passID
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


