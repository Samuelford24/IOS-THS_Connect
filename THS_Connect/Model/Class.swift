//
//  User.swift
//  THS_Connect
//
//  Created by Samuel Ford on 6/11/19.
//  Copyright © 2019 Samuel Ford. All rights reserved.
//

import UIKit

class Class: NSObject {
    var date_clasname: String?
    var teacher: String?
    var room_number: String?
    var class_id: String?
    init(dictionary: [String: Any]) {
        self.date_clasname = dictionary["date_clasname"] as? String ?? ""
        self.teacher = dictionary["teacher"] as? String ?? ""
        self.room_number = dictionary["room_number"] as? String ?? ""
        self.class_id = dictionary["uid"] as? String ?? ""
    }
}
