//
//  CategoryBottomView.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/11/2.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol CategoryBotttomDelegate:class {
	func pushM(_ button :UIButton) -> Void
}
class CategoryBottomView: UIView {

	var dataArry = [CategoryBottomModel]()
	var downView = UIView()
	weak var delegate:CategoryBotttomDelegate!
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		loadData()
		
	}
	
	func  createUI() -> Void {
		downView.frame.size.width = SCREEN_W;
		downView.backgroundColor = UIColor.white;
		let lable = UILabel();
		lable.text = "品类";
		lable.textColor = UIColor.init(white: 0.4, alpha: 1);
		lable.frame = CGRect(x: 10, y: 0, width: SCREEN_W - 10, height: 40);
		downView.addSubview(lable);
		self.addSubview(downView);
		
		let space: CGFloat = 20;
		let btnW = (SCREEN_W - 5 * space) / 4;
		downView.frame.size.height = btnW + 500 + lable.mj_h;
		var i = 0;
		var tag = [13,14,15,16,17,18,22]
		for model in dataArry {
			let orginX = CGFloat(i % 4) * (btnW + space) + space;
			let orginY = CGFloat(i / 4) * (btnW + space + 10) + 40
			
			let btn = UIButton.init(frame: CGRect(x: orginX, y: orginY, width: btnW, height: btnW));
			btn.sd_setBackgroundImage(with: URL.init(string: model.iconUrl), for: UIControlState());
			btn.sd_setBackgroundImage(with: URL.init(string: model.iconUrl), for: .highlighted);
			btn.setTitle(model.name, for: UIControlState());
			btn.setTitleColor(UIColor.black, for: UIControlState());
			btn.titleLabel?.font = UIFont.init(name: "Helvetica-Light", size: 14);
			btn.titleEdgeInsets = UIEdgeInsetsMake(btnW + 30, 0, 0, 0);
			btn.addTarget(self, action: #selector(self.btnAction(_:)), for: UIControlEvents.touchUpInside);
			btn.tag = tag[i];
			self.downView.addSubview(btn);
			i += 1;
		}

		
		
	}
	
	func heightNoti() -> Void {
		
	}
	func loadData() -> Void {
		let url = BASE_URL + "v1/channel_groups/all"
		BaseRequest.getWithURL(url, para: nil) { (data, error ) in
			let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.mutableContainers);
			let btnArray = obj["data"]["channel_groups"].arrayValue;
			let group1 = btnArray[1];
			let item1 = group1["channels"].arrayValue;
			for item in item1 {
				let model = CategoryBottomModel.init(fromJson: item);
				model.iconUrl = item["icon_url"].string;
				model.name = item["name"].string;
				self.dataArry.append(model);
			}
			DispatchQueue.main.async(execute: {
				self.createUI();
			})
		

		}
	}
	
	func btnAction (_ button: UIButton) -> Void {
		self.delegate.pushM(button)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
