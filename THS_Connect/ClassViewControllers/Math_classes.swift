//
//  Math_classesTableViewController.swift
//  THS_Connect
//
//  Created by Samuel Ford on 6/12/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase

/*class class_custom_cell: UITableViewCell {
    
    @IBOutlet weak var date_classname: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var room_number: UILabel!
}*/
/*
class Math_classes: UITableViewController {
    let cellId = "cellId"
    
    
    var users = [Class]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.rowHeight = 80;
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        //   tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchClass()
    }
    
    func fetchClass() {
        // guard let uid = ?.user.uid
        // else{return}
        //let userID = Auth.auth().currentUser!.uid
        Database.database().reference().child("Math").observe(.childAdded, with: { (snapshot) in
            //print(userID)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = Class(dictionary: dictionary)
                self.users.append(user)
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
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let use a hack for now, we actually need to dequeue our cells for memory efficiency
        //        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_class", for: indexPath) as! class_custom_cell
        
        let Class = users[indexPath.row]
        cell.date_classname?.text = Class.date_clasname
        cell.teacher?.text = Class.teacher
        cell.room_number?.text = Class.room_number
        
        return cell
    }
    
}
*/
