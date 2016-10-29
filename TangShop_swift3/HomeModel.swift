//
//  HomeModel.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/17.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeModel: NSObject {

    var contentUrl:String!
    var coverImageUrl:String!
    var createdAt:Int!
    var editorId:AnyObject!
    var id :Int!
    var labels:[AnyObject]!
    var liked:Bool!
    var likesCount:Int!
    var publishedAt:Int!
    var shareMsg:String!
    var shortTitle:String!
    var status:Int!
    var template:String!
    var title:String!
    var type:String!
    var updataedAt:Int!
    var url:String!
    
    init(fromJson json: JSON) {
        
        if json == nil {
            return
        }
        contentUrl = json["content_url"].stringValue
        coverImageUrl = json["cover_image_url"].stringValue
        createdAt = json["created_at"].intValue
        editorId = json["editor_id"].stringValue as AnyObject!
        id = json["id"].intValue
        labels = json["labels"].arrayValue as [AnyObject]!
        liked = json["liked"].boolValue
        likesCount = json["likes_count"].intValue
        publishedAt = json["publish_at"].intValue
        shareMsg = json["share_msg"].stringValue
        shortTitle = json["short_title"].stringValue
        status = json["status"].intValue
        template = json["template"].stringValue
        title = json["title"].stringValue
        type = json["type"].stringValue
        updataedAt = json["updataed_at"].intValue
        url = json["url"].stringValue

        
    }
    
    
}
