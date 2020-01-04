//
//  ToggleClasses.swift
//  THS_Connect
//
//  Created by Samuel Ford on 1/2/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class ToggleClasses: UIViewController {
    @IBOutlet weak var labelView: UILabel!
    let ref=Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
        loadData()
    }
    @IBAction func CloseClasses(_ sender: Any) {
        ref.child("Toggle_Classes").setValue("Classes Closed")
        loadData()
       // labelView.text="Classes Closed"
    }
    @IBAction func OpenClasses(_ sender: Any) {
        ref.child("Toggle_Classes").setValue("Classes are Open")
        loadData()
        //labelView.text="Classes areopen"
    
    
    }
    func loadData() {
        // code to load data from network, and refresh the interface
        ref.child("Toggle_Classes").observeSingleEvent(of: .value, with: { (snapshot) in
               if let dictionary = snapshot.value as? String {
                print(dictionary)
                   self.labelView.text = dictionary
                   }
                   
               })
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
