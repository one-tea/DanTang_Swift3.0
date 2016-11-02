//
//  CategoryMidView.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/11/1.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol CategoryButtonDelegate: class  {
	func push(_ button: UIButton) -> Void
}

class CategoryMidView: UIView {
	
	var topView:UIView!
	
	var buttonModelArry = [CategoryBottomModel]()
	
	weak var delegate: CategoryButtonDelegate!
	
	override init(frame: CGRect) {
		
		super.init(frame: frame)
		self.loadButtonData()
	}
	
	func setUI() -> Void {
		
		let btnW = (SCREEN_W - 20*5)/4
		
		let space: CGFloat = 20;
		
		topView = UIView.init()
		topView.backgroundColor = UIColor.white
		topView.frame.size.width = SCREEN_W
		self.addSubview(topView)
		// id 为12，19
		let	 tag = [12, 19, 20, 21]
		let  label  = UILabel.init(frame:CGRect( x: 10, y: 0, width: SCREEN_W - 10, height: 40))
		label.text = "风格"
		topView.addSubview(label)
		topView.frame.size.height = btnW + 30 + label.mj_h;
		var i = 0
		for model in buttonModelArry {
			
			let button  = UIButton.init()
			let orginx = CGFloat(i % 4) * (btnW + space) + space
			let orginy = CGFloat(i / 4) * (btnW + space) + 40
			
			button.frame = CGRect(x:orginx , y: orginy, width: btnW, height: btnW)
			button.sd_setBackgroundImage(with: URL.init(string: model.iconUrl), for: UIControlState())
			button.setTitle(model.name, for: UIControlState())
			button.setTitleColor(UIColor.black, for: UIControlState())
			button.titleLabel?.font = UIFont.init(name: "Helvetica-Light", size: 14);
			button.titleEdgeInsets = UIEdgeInsetsMake(btnW + 30, 0, 0, 0);
			button.tag = tag[i]
			button.addTarget(self, action: #selector(push(_:)), for: UIControlEvents.touchUpInside)
			topView.addSubview(button)
			i += 1
			
		}
	}
	func midVieHieght()->CGFloat{
		
		let space: CGFloat = 20;
		let btnW = (SCREEN_W - 5 * space) / 4
//		topView.frame.size.height = ;
		
		return  btnW + 30 + 40
	}

	func loadButtonData() -> Void {
		let url = BASE_URL + "v1/channel_groups/all"
	BaseRequest.getWithURL(url, para: nil) { (res ,  error ) in
		let obj = JSON.init(data: res! , options: JSONSerialization.ReadingOptions.mutableContainers)
		
		let btnArray = obj["data"]["channel_groups"].arrayValue;
		let group1 = btnArray[0];
		let item1 = group1["channels"].arrayValue;
		for item in item1 {
			let model = CategoryBottomModel.init(fromJson: item);
			model.iconUrl = item["icon_url"].string;
			model.name = item["name"].string;
			self.buttonModelArry.append(model);
		}
		
		DispatchQueue.main.async(execute: { 
			self.setUI()

		})
		}
	
	}
	
	func push(_ button: UIButton) -> Void {
		self.delegate.push(button)
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
