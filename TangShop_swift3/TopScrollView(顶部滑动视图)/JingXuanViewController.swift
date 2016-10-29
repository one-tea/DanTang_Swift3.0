//
//  JingXuanViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/17.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit

import SDCycleScrollView
import MJRefresh
import SwiftyJSON
import AFNetworking

class JingXuanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate {
    
    lazy var adView: SDCycleScrollView = {
        let adView = SDCycleScrollView.init(frame: CGRect(x: 10, y: 0, width: SCREEN_W - 20, height: 150), delegate: self, placeholderImage: nil);
        adView?.layer.cornerRadius = 5;
        adView?.layer.masksToBounds = true;
        return adView!
    }()

    lazy var tableView: UITableView =  {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H))
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsetsMake(30, 0, 143, 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator=false
        tableView.tableHeaderView = self.headerView
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        return tableView
        
    }()
    
    lazy var headerView: UIView  = {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 150))
        headerView.addSubview(self.adView)
        return headerView
    }()
    
    lazy var manager:AFHTTPSessionManager = {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        return manager
    }()
    
    var dataArr = [HomeModel]();
    var ofSet = 0;
    var urlArr = [String]();
    
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.mj_header = MJRefreshNormalHeader.init( refreshingBlock:{
            
            self.ofSet = 0;
            self.loadData()
            
        })
        self.tableView.mj_footer = MJRefreshFooter.init(refreshingBlock:{
            self.ofSet += 20
            self.loadData()
        })
        self.loadHeaderData()
        self.loadData()
        self.view.addSubview(tableView);

        // Do any additional setup after loading the view.
    }
    
    func loadHeaderData() -> Void {
        let url = "http://api.dantangapp.com/v1/banners?channel=iOS"
       
        
       manager.get(url, parameters: nil, progress: nil, success: { (task, resp) in
            
            let obj = JSON.init(data: resp as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
//            print("obj:\(obj)")
            let bannesArr = obj["data"]["banners"].arrayValue
            for dic in bannesArr{
                self.urlArr.append(dic["image_url"].stringValue)
            }
            self.adView.imageURLStringsGroup=self.urlArr
            }) { (task, error) in
                print(error)
        }
        
        
    }
    func loadData() ->Void{
    
        let url = BASE_URL + "v1/channels/4/items"
        let para = ["gender": "1",
                     "generation": "1",
                     "limit": "20",
                     "offset": String(self.ofSet)]
        manager.get(url , parameters: para, progress: nil, success: { (task, resp) in
            
            let obj = JSON.init(data: resp as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
//            print("dataObj:\(obj)")

            for json in obj["data"]["items"].arrayValue{
              let model = HomeModel.init(fromJson: json)
                self.dataArr.append(model)
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
        return self.dataArr.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let model  = dataArr[indexPath.row]
        
        cell.headImage.setImageWith(URL.init(string: model.coverImageUrl)!, placeholderImage: nil)
        cell.titleL.text = model.title
        cell.likeBtn.setTitle(String(model.likesCount), for: UIControlState())
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //选择
        
        let jxDetailVC = JXDetailViewController()
        let model = dataArr[indexPath.row]
        
        jxDetailVC.url = model.url
        jxDetailVC.coverUrl = model.coverImageUrl;
        jxDetailVC.titleL = model.title;
        jxDetailVC.shareMsg = model.shareMsg;
        jxDetailVC.navigationItem.title = "攻略详情";

        self.navigationController?.pushViewController(jxDetailVC, animated: true)
        
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
