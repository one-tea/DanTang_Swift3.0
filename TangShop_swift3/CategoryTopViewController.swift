//
//  CategoryTopViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/26.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON

class CategoryTopViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame:CGRect(x: 0, y: 40, width: SCREEN_W, height: 85), collectionViewLayout: layout)
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.showsVerticalScrollIndicator = false
		collectionView.backgroundColor = UIColor.white;
		collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "CategoryTopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryTopCollectionViewCell")
        return collectionView
    }()
    
    lazy var manager: AFHTTPSessionManager = {
        let manager =  AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        return manager
    }()
    
	
    var dataArr = [CategoryTopViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadData()
		
		setUI()
    }
    
    func loadData() -> Void {
        let url = BASE_URL + "v1/collections"
        let para = ["limit":"4","offset":"0"]
        
        manager.get(url, parameters: para, progress: nil, success: { (task, res) in
            let obj = JSON.init(data: res as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
//            print("topObj:\(obj)")
			
			let collectionArry = obj["data"]["collections"].arrayValue
			for item  in collectionArry {
				
				let topModel = CategoryTopViewModel.init(fromJson: item)
				self.dataArr.append(topModel!)
			}
			
            self.collectionView.reloadData()
			
            }) { (task, error ) in
                print("失败")
        }
    }

	/**
		文档注释
	
		- add headerLabel
		- add collectionView
	*/
	func setUI() -> Void {
		
		self.navigationController?.navigationBar.isTranslucent = false
		let headerL = UILabel.init(frame: CGRect(x:0, y: 0, width: SCREEN_W, height: 40))
			headerL.text = " 专题合集"
		headerL.backgroundColor = UIColor.white
			headerL.font = UIFont.systemFont(ofSize: 17)
		self.view.addSubview(headerL)
		
		self.view.addSubview(self.collectionView)
		
	}
	
    //MARK: - CollectionView detegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 150, height: 75)
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(10, 10, 10, 10)
	}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryTopCollectionViewCell", for: indexPath) as! CategoryTopCollectionViewCell

		let model = dataArr[indexPath.row]
		
		topCell.imageView.sd_setImage(with: URL.init(string: model.bannerImageUrl))
        
        return topCell
        
    }
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let  model  = dataArr[indexPath.row]
		let  cateTopDetailVC = CategoryDetailViewController()
		cateTopDetailVC.id = model.id
		self.navigationController?.pushViewController(cateTopDetailVC, animated: true)
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
