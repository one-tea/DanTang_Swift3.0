//
//  CategoryTopViewModel.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/31.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SwiftyJSON
class CategoryTopViewModel: NSObject {
	/*"banner_image_url" = "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150809/a5h1ygeaz.jpg-w300";
	"cover_image_url" = "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150809/xcfrysr3i.jpg-w720";
	"created_at" = 1439086194;
	id = 4;
	"posts_count" = 3;
	status = 0;
	subtitle = "\U5b9e\U7528\U795e\U5668\U5408\U8f91";
	title = "\U751f\U6d3b\U4e2d\U7684\U5b9e\U7528\U795e\U5668";
	"updated_at" = 1439086194;*/
	
	var bannerImageUrl: String!
	var coverImageUrl: String!
	var createdAt: Int!
	var id: Int!
	var postsCount: Int!
	var status: Int!
	var subtitle: String!
	var title: String!
	var updatedAt: Int!
	
	init?(fromJson json : JSON!) {
		
		guard  let json = json else {
			return nil
		}
		
		bannerImageUrl = json["banner_image_url"].stringValue
		coverImageUrl = json["cover_image_url"].stringValue
		createdAt = json["created_at"].intValue
		id = json["id"].intValue
		postsCount = json["posts_count"].intValue
		status = json["status"].intValue
		subtitle = json["subtitle"].stringValue
		title = json["title"].stringValue
		updatedAt = json["updated_at"].intValue
		
	}

}
