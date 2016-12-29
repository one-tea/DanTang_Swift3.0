//
//  HomeSearchModel.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import Foundation
import SwiftyJSON
class HomeSearchModel{
    
    var coverImageUrl : String!
    var descriptionField : String!
    var favoritesCount : Int!
    var id : Int!
    var liked : Bool!
    var likesCount : Int!
    var name : String!
    var price : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        coverImageUrl = json["cover_image_url"].stringValue
        descriptionField = json["description"].stringValue
        favoritesCount = json["favorites_count"].intValue
        id = json["id"].intValue
        liked = json["liked"].boolValue
        likesCount = json["likes_count"].intValue
        name = json["name"].stringValue
        price = json["price"].stringValue
    }
    
}
