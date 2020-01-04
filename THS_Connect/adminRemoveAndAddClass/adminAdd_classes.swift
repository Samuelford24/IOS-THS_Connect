//
//  adminAdd_classes.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/6/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit

class adminAdd_classes: UIViewController {
    var passClassType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func science(_ sender: Any) {
        passClassType = "Science"
        performSegue(withIdentifier: "adminADD", sender: self)
    }
    @IBAction func english(_ sender: Any) {
        passClassType = "English"
        performSegue(withIdentifier: "adminADD", sender: self)
    }
    @IBAction func math(_ sender: Any) {
        passClassType = "Math"
        performSegue(withIdentifier: "adminADD", sender: self)
    }
    @IBAction func ss(_ sender: Any) {
        passClassType = "Social Studies"
        performSegue(withIdentifier: "adminADD", sender: self)
    }
    @IBAction func technology(_ sender: Any) {
        
        passClassType = "Technology"
        performSegue(withIdentifier: "adminADD", sender: self)
    }
    @IBAction func other(_ sender: Any) {
        passClassType = "Other"
        performSegue(withIdentifier: "adminADD", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="adminADD") {
            var viewController = segue.destination as! adminAdd_subjects
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
