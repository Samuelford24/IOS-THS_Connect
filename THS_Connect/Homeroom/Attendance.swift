//
//  Attendance.swift
//  THS_Connect
//
//  Created by Samuel Ford on 2/23/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class Attendance: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var uid: String!
    var array = [String]()
     var ref : DatabaseReference!
     var handle: DatabaseHandle!
     
    @IBOutlet weak var attendance: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

   
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        handle = ref?.child("Users").child(uid).child("Attendance").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String {
                self.array.append(item)
                self.attendance.reloadData()
                
            }
            
        })
        
      
    }
   /* func createPdfFromTableView()
    {
        let priorBounds: CGRect = self.Tableview_announcements.bounds
        let fittedSize: CGSize = self.Tableview_announcements.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.Tableview_announcements.contentSize.height))
        self.Tableview_announcements.bounds = CGRect(x: 0, y: 0, width: fittedSize.width, height: fittedSize.height)
        self.Tableview_announcements.reloadData()
        let pdfPageBounds: CGRect = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
        let pdfData: NSMutableData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        self.Tableview_announcements.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let documentsFileName = documentDirectories! + "/" + "Announcements"
        pdfData.write(toFile: documentsFileName, atomically: true)
        print("1",documentsFileName)
    }
    */
     func numberOfSections(in tableView: UITableView) -> Int {
                   // #warning Incomplete implementation, return the number of sections
                   return 1
               }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = attendance.dequeueReusableCell(withIdentifier: "attendance")! as UITableViewCell
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
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


