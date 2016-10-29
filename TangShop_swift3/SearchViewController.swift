//
//  SearchViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/20.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init()
        searchBar.delegate = self
        searchBar.placeholder = "搜索商品、专题";
        return searchBar
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib.init(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        
        return tableView
    }()
    
    lazy var manager : AFHTTPSessionManager = {
        let manager = AFHTTPSessionManager.init()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = AFHTTPRequestSerializer()
        return manager
    }()
    
    var dataArr  = [HomeSearchModel]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNav()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.becomeFirstResponder()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.searchBar.resignFirstResponder()
    }
    
    
    func  setNav () -> Void   {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.done, target: self, action: #selector(canleBtnClick))
        self.navigationItem.titleView  = self.searchBar
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
        
    }
    func canleBtnClick() -> Void {
        
      _ = navigationController?.popViewController(animated:true)

    }

    //searching keyword 接口已更改
    func searchKeyGetData (_ keyWord: String?) -> Void {
        let url  = "http://api.dantangapp.com/v1/search/items"
        let para = ["keyword": keyWord,
                    "limit": "20",
                    "offset": "0",
                    "sort": ""];
        print("\(url)&\(para)")
        
        self.manager.get(url, parameters: para, progress: nil, success: { (task, res ) in
            let obj = JSON.init(data: res as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print("search:\(obj)")
            let modelArray = obj["data"]["items"].arrayValue
            for item in modelArray {
                let model = HomeSearchModel.init(fromJson: item)
                self.dataArr.append(model)
            }
            self.tableView.reloadData()
            
            }) { (task, error ) in
                print("search:\(error)")
        }
        
    }
    
    //searchBarDetegate
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.addSubview(self.tableView)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.dataArr.removeAll()
        self.searchKeyGetData(searchBar.text)
        
    }
    
    //tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let model = dataArr[indexPath.row]
        
        cell.headImageView .sd_setImage(with: URL.init(string:model.coverImageUrl))
        cell.titleL.text = model.name
        cell.priceL.text = "￥" + model.price
        cell.selectionStyle = .none
        return cell
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
