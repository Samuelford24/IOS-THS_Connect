//
//  SetHomeroom.swift
//  THS_Connect
//
//  Created by Samuel Ford on 2/29/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
class SetHomeroom: UIViewController {

    @IBOutlet weak var homeroomEntry: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func SaveHomeroom(_ sender: Any) {
        if(self.homeroomEntry.text==""){
            //must enter somerthing
            print("null")
        }
        else{
            let c = Database.database().reference().child(homeroomEntry.text!)
            print(c)
            
                c.observe(.childAdded, with: { (snapshot) in
                print(snapshot)
                    //need to fix
                if(snapshot==nil){
                    let ac = UIAlertController(title: "Homeroom doesn't exist", message:"Please try entering a correct homeroom reference; if the problem persists, please email svhsdev@vigoschools.org", preferredStyle: UIAlertController.Style.alert)
                          let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                              ac.dismiss(animated: true, completion: nil)               })
                          
                          
                          
                          ac.addAction(OKaction)
                    self.present(ac, animated: true, completion: nil)
        }
                else{
                    Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("HR").setValue(self.homeroomEntry.text!)
                    let ac = UIAlertController(title: "Homeroom Added", message:nil, preferredStyle: UIAlertController.Style.alert)
                          let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                              ac.dismiss(animated: true, completion: nil)               })
                          
                          
                          
                          ac.addAction(OKaction)
                    self.present(ac, animated: true, completion: nil)
                }
       
            })
            
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
