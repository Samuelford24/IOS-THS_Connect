//
//  adminVS_subjects.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/1/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit

class adminVS_subjects: UIViewController {
    var passClassType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func science(_ sender: Any) {
        passClassType = "Science"
         performSegue(withIdentifier: "admin_vs_show_class", sender: self)
    }
    @IBAction func english(_ sender: Any) {
        passClassType = "English"
        performSegue(withIdentifier: "admin_vs_show_class", sender: self)
    }
    @IBAction func math(_ sender: Any) {
        passClassType = "Math"
        performSegue(withIdentifier: "admin_vs_show_class", sender: self)
    }
    @IBAction func ss(_ sender: Any) {
        passClassType = "Social Studies"
        performSegue(withIdentifier: "admin_vs_show_class", sender: self)
    }
    @IBAction func tech(_ sender: Any) {
       passClassType = "Technology"
        performSegue(withIdentifier: "admin_vs_show_class", sender: self)
    }
    @IBAction func other(_ sender: Any) {
        passClassType = "Other"
        performSegue(withIdentifier: "admin_vs_show_class", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="admin_vs_show_class") {
            var viewController = segue.destination as! adminVS_classes
            viewController.passedValue = passClassType
            
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
