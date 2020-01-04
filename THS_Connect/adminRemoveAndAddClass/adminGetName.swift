//
//  adminGetName.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/3/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit

class adminGetName: UIViewController {

    @IBOutlet weak var tf: UITextField!
    var studentName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func adminRClass(_ sender: Any) {
         studentName = tf.text!
        performSegue(withIdentifier: "adminRemove", sender: self)
    }
  
    @IBAction func admin_addClass(_ sender: Any) {
        studentName = tf.text!
        UserDefaults.standard.set(studentName!, forKey: "studentName")
        performSegue(withIdentifier: "adminAddClass", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="adminRemove") {
            var viewController = segue.destination as! adminRemoveC_showClasses
            viewController.passedValue = studentName
            
        }
        else if(segue.identifier=="adminAddClass") {
            var viewController = segue.destination as! adminAdd_classes
          //  viewController.passedValue = studentName
            
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

}
