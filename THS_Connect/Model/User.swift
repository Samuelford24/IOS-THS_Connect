//
//  User.swift
//  THS_Connect
//
//  Created by Samuel Ford on 8/2/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String!
    var grade: String!
    var studentID: String!
    var uid: String!
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.grade = dictionary["grade"] as? String ?? ""
        self.studentID = dictionary["studentID"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
    

}
