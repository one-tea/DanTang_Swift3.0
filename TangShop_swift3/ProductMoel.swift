//
//  ProductMoel.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/24.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SwiftyJSON
class ProductMoel: NSObject {

    var brandId : AnyObject!
    var brandOrder : Int!
    var categoryId : AnyObject!
    var coverImageUrl : String!
    var createdAt : Int!
    var descriptionField : String!
    var editorId : Int!
    var favoritesCount : Int!
    var id : Int!
    var imageUrls : [String]!
    var isFavorite : Bool!
    var name : String!
    var postIds : [AnyObject]!
    var price : String!
    var purchaseId : String!
    var purchaseStatus : Int!
    var purchaseType : Int!
    var purchaseUrl : String!
    var subcategoryId : AnyObject!
    var updatedAt : Int!
    var url : String!
    
    
    init(jsonFrom json:JSON) {
        if json == nil {
            return
        }
        brandId = json["brandId"].stringValue as AnyObject!
        brandOrder = json["brandOrder"].intValue
        categoryId = json["category_id"].stringValue as AnyObject!
        coverImageUrl = json["cover_image_url"].stringValue
        createdAt = json["created_at"].intValue
        descriptionField = json["description"].stringValue
        editorId = json["editor_id"].intValue
        favoritesCount = json["favorites_count"].intValue
        id = json["id"].intValue
        imageUrls = [String]()
        let imageUrlsArray = json["image_urls"].arrayValue
        for imageUrlsJson in imageUrlsArray{
            imageUrls.append(imageUrlsJson.stringValue)
        }
//        imageUrls = json["image_urls"].arrayValue as [AnyObject] as! [String]//json ()->anyobject->string -NO
        isFavorite = json["is_favorite"].boolValue
        name = json["name"].stringValue
        postIds = [AnyObject]()
        let postIdsArray = json["post_ids"].arrayValue
        for postIdsJson in postIdsArray{
            postIds.append(postIdsJson.stringValue as AnyObject)
        }
        price = json["price"].stringValue
        purchaseId = json["purchase_id"].stringValue
        purchaseStatus = json["purchase_status"].intValue
        purchaseType = json["purchase_type"].intValue
        purchaseUrl = json["purchase_url"].stringValue
        subcategoryId = json["subcategory_id"].stringValue as AnyObject!
        updatedAt = json["updated_at"].intValue
        url = json["url"].stringValue

        
    }
}
