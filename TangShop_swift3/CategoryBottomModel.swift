//
//  CategoryBottomModel.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/30.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import Foundation
import SwiftyJSON
class CategoryBottomModel{
    
    var groupId : Int!
    var iconUrl : String!
    var id : Int!
    var itemsCount : Int!
    var name : String!
    var order : Int!
    var status : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        groupId = json["group_id"].intValue
        iconUrl = json["icon_url"].stringValue
        id = json["id"].intValue
        itemsCount = json["items_count"].intValue
        name = json["name"].stringValue
        order = json["order"].intValue
        status = json["status"].intValue
    }
    
}
