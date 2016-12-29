//
//  FoodViewViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/17.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage
import MJRefresh
import SwiftyJSON
class FoodViewViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

   lazy var tableView :UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H), style: UITableViewStyle.plain)
        tableView.contentInset = UIEdgeInsetsMake(30, 0, 64+49, 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        return tableView
        
    }()
    
    lazy var manager: AFHTTPSessionManager = {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        return manager
    }()
    
    var dataArry = [HomeModel]()
    var offset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.offset = 0
            self.loadData()
        })
        self.tableView.mj_footer = MJRefreshFooter.init(refreshingBlock: { 
            self.offset += 20
            self.loadData()
        })
        self.view.addSubview(self.tableView)
        self.loadData()

    }
    func loadData() -> Void {
        let url = BASE_URL + "v1/channels/14/items"
        let para = ["gender": "1",
                    "generation": "1",
                    "limit": "20",
                    "offset": String(self.offset)];
        
        self.manager.get(url, parameters: para, progress: nil, success: { (task, res) in
            let obj = JSON.init(data:res as! Data)
            for json in obj["data"]["items"].arrayValue{
                let model = HomeModel.init(fromJson: json)
                self.dataArry.append(model)
                self.tableView .reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            }
            }) { (task, error) in
                print(error)
        }
    }
    
    //tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArry.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
            
            let model = dataArry[indexPath.row]
            
            cell.headImage.sd_setImage(with: URL.init( string: model.coverImageUrl)!)
            cell.titleL.text = model.title
            cell.likeBtn.setTitle(String(model.likesCount), for: UIControlState())
            cell.selectionStyle = .none
            return cell
        
    }
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1)
		UIView.animate(withDuration: 0.8, animations: {
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
