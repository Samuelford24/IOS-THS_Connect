//
//  CollectionViewController.swift
//  THS_Connect
//
//  Created by Samuel Ford on 7/6/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    let classes = ["English","Math","Science","Social Studies","Other","Technology"]
    let class_images : [UIImage] = [
        UIImage(named: "English")!,
        UIImage(named: "Math")!,
        UIImage(named: "Science")!,
        UIImage(named: "Social Studies")!,
        UIImage(named: "Other")!,
        UIImage(named: "Technology")!
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
      var layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22)
        layout.minimumInteritemSpacing = 22
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return classes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "class_cell", for: indexPath) as! custom_class_cell
        cell.class_name.text = classes[indexPath.item]
        cell.class_image.image = class_images[indexPath.item]
        // Configure the cell
    cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    var valueToPass:String!
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     valueToPass = classes[indexPath.row]
        print(valueToPass)
        //let currentCell = collectionView.cellForItem(at: indexpath) as! custom_class_cell
        //print(currentCell)
        performSegue(withIdentifier: "show_class", sender: self)
            
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="show_class") {
            var viewController = segue.destination as! Science_classes
            viewController.passedValue = valueToPass
           
        }
        
    }
}



