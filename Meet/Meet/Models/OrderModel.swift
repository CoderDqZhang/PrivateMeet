//
//  OrderModel.swift
//  Meet
//
//  Created by Zhang on 7/14/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import UIKit

class OrderModel: NSObject {
    
    var status: Status?
    
    var order_user_info: Order_User_Info?
    
    var order_id: String = ""
    
    var distance: String = ""
    
    var appointment_desc: String = ""
    
    var appointment_theme: NSArray = []
    
    var created_at: String = ""
    
    var meeted_days : String = ""
    
    var fee : String = ""
    
    var reject_type_desc : String = ""
    
    var reject_reason : String = ""
}

class Status: NSObject {
    
    var front_status: String = ""
    
    var order_status: String = ""
    
    var status_code: String = ""
    
    var status_type: String = ""
    
}

class Order_User_Info: NSObject {
    
    var avatar: String = ""
    
    var weixin_num: String = ""
    
    var mobile_num: String = ""
    
    var real_name: String = ""
    
    var job_label: String = ""
    
    var uid : String = ""
    
    var gender : NSInteger = 0

}


