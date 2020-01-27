//
//  HomeroomList.swift
//  THS_Connect
//
//  Created by Samuel Ford on 1/23/20.
//  Copyright © 2020 Samuel Ford. All rights reserved.
//

import UIKit

class HomeroomList: UIViewController {
    @IBOutlet weak var ac: UIButton!
    @IBOutlet weak var dg: UIButton!
    @IBOutlet weak var hl: UIButton!
    @IBOutlet weak var mo: UIButton!
    @IBOutlet weak var ps: UIButton!
    
    @IBOutlet weak var tz: UIButton!
    var hrRef=""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func ac(_ sender: Any) {
        hrRef="HR1"
        print(hrRef)
         performSegue(withIdentifier: "hr", sender: nil)
    }
    @IBAction func dg(_ sender: Any) {
           hrRef="HR2"
           print(hrRef)
         performSegue(withIdentifier: "hr", sender: nil)
    }
    @IBAction func hl(_ sender: Any) {
           hrRef="HR3"
           print(hrRef)
         performSegue(withIdentifier: "hr", sender: nil)
    }
    @IBAction func mo(_ sender: Any) {
           hrRef="HR4"
           print(hrRef)
         performSegue(withIdentifier: "hr", sender: nil)
    }
    @IBAction func ps(_ sender: Any) {
           hrRef="HR5"
           print(hrRef)
         performSegue(withIdentifier: "hr", sender: nil)
    }
    @IBAction func tz(_ sender: Any) {
           hrRef="HR6"
           print(hrRef)
        performSegue(withIdentifier: "hr", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier=="hr") {
            var viewController = segue.destination as! HRTeachersList
               viewController.HRref = hrRef
               
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
}
