//
//  CategoryDetailViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/11/1.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON
class CategoryDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

	lazy var manager : AFHTTPSessionManager = {
		let manager = AFHTTPSessionManager()
		manager.responseSerializer = AFHTTPResponseSerializer()
		return manager
	}()
	
	lazy var tableView: UITableView = {
		
		let  tableView = UITableView.init(frame: self.view.frame)
		tableView.showsVerticalScrollIndicator = false
		tableView.separatorStyle = .none
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell");
		return tableView
	}()
	
	var dataArry = [CategoryTopDetailModel]()
	var id:Int!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style:.plain, target: nil, action: nil)
		self.navigationItem.title = "攻略详情"
		setUI()
		loadData()
	}
	
	func setUI() -> Void {
		
		self.view.addSubview(self.tableView)
		
	}
	func  loadData () -> Void {
		let  url	= BASE_URL + "v1/collections/\(id!)/posts"
		let  param	=  ["gender": "1",
		                "generation": "1",
		                "limit": "20",
		                "offset": "0"]
		self.manager.get(url, parameters: param, progress: nil, success: { (task, res) in
			let obj = JSON.init(data: res as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
			let cateTopDetailArray = obj["data"]["posts"].arrayValue;
			for post in cateTopDetailArray{
				
				let model = CategoryTopDetailModel.init(fromJson: post)
				
				self.dataArry.append(model)
				self.tableView .reloadData()
			}

			}) { (task, error) in
				print("detailFail")
		}
		
		
	}
	
	//MARK - tableView delegate
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArry.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 170
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
		
		let model  = dataArry[indexPath.row]
		cell.headImage.sd_setImage(with: URL.init(string: model.coverImageUrl))
		cell.titleL.text = model.title
		cell.likeBtn.setTitle(String(model.likesCount), for: UIControlState())
		
		
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model  = dataArry[indexPath.row]
		let topViwDetailWebVC = JXDetailViewController()
		topViwDetailWebVC.url = model.contentUrl
		//TODE:  分享用
		/*topViwDetailWebVC.coverUrl = model.coverImageUrl;
		topViwDetailWebVC.titleL = model.title;
		topViwDetailWebVC.shareMsg = model.shareMsg
		*/
		self.navigationController?.pushViewController(topViwDetailWebVC, animated: true)
	}
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
		UIView.animate(withDuration: 0.5, animations: { 
			cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
			}, completion: nil)
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
