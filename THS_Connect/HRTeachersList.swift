//
//  HRTeachersList.swift
//  THS_Connect
//
//  Created by Samuel Ford on 1/26/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class HRTeachersList: UITableViewController {
    var HRref: String!
    var hrRefToPass: String!
    
    var teacher: String!
    var teachers = [String?]()
    override func viewDidLoad() {
        super.viewDidLoad()

        print(HRref)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getTeachers()
    }
    func getTeachers(){
        let  b = Database.database().reference().child(HRref)
        b.observe(.childAdded, with: { (snapshot) in
            print(snapshot.key)
            let bf=snapshot.key
            print(bf)
            self.teachers.append(bf)
            self.tableView.reloadData()
            
        
    })
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teachers.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hr", for: indexPath)
cell.textLabel?.text = teachers[indexPath.row]
       cell.textLabel?.numberOfLines = 0

        // Configure the cell...

        return cell
    }
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let indexPath = tableView.indexPathForSelectedRow!
       let currentCell = tableView.cellForRow(at: indexPath)! as! UITableViewCell
         teacher=currentCell.textLabel?.text
        print(teacher)
        performSegue(withIdentifier: "HrSTUDENTS", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="HrSTUDENTS") {
            let viewController = segue.destination as! StudentsInHomeroom
               viewController.teacher = teacher
            viewController.hrRefToPass = hrRefToPass
           
       
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    }

}
