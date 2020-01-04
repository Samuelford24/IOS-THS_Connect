//
//  setting.swift
//  THS_Connect
//
//  Created by Samuel Ford on 5/26/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class setting: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func questions(_ sender: Any) {
        let ac = UIAlertController(title: "Questions? ", message:"Email svhsdev@vigoschools.org", preferredStyle: UIAlertController.Style.alert)
        let OKaction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            ac.dismiss(animated: true, completion: nil)               })
        
        
        
        ac.addAction(OKaction)
        present(ac, animated: true, completion: nil)
    }
    @IBAction func report(_ sender: Any) {
        let ac = UIAlertController(title: "Report a bug or Get Support? ", message: nil, preferredStyle: UIAlertController.Style.alert)
        let OKaction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            if let url = URL(string: "https://forms.gle/kqBEcPDD8axhevcj8") {
                UIApplication.shared.open(url, options: [:])
            }
        })
        let NOaction = UIAlertAction(title:"No", style: UIAlertAction.Style.default, handler:{ action in
            ac.dismiss(animated: true, completion: nil)               })
        
        
        
        ac.addAction(OKaction)
        ac.addAction(NOaction)
        present(ac, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func privacypolicy(_ sender: Any) {
        let ac = UIAlertController(title: "View the privacy policy and terms and conditions?", message: nil, preferredStyle: UIAlertController.Style.alert)
        let OKaction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            if let url = URL(string: "https://forms.gle/zpye6zUemHtEZpTT9") {
                UIApplication.shared.open(url, options: [:])
            }
        })
        let NOaction = UIAlertAction(title:"No", style: UIAlertAction.Style.default, handler:{ action in
            ac.dismiss(animated: false, completion: nil)               })
        
        
        
        ac.addAction(OKaction)
        ac.addAction(NOaction)
        present(ac, animated: true, completion: nil)
        
        
    }
    
    @IBAction func sign_out(_ sender: Any) {
    
   
       if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                self.navigationController?.dismiss(animated: true, completion: nil)
               // let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
              //  present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
       else if Auth.auth().currentUser == nil {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        present(vc, animated: true, completion: nil)
        
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
