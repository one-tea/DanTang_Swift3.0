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
        let collectionView = UICollectionView.init(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)

        collectionView.register(UINib.init(nibName: "CategoryTopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryTopCollectionViewCell")
        return collectionView
    }()
    
    lazy var manager: AFHTTPSessionManager = {
        let manager =  AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        return manager
    }()
    
    
    var dataArr = [CategoryModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData() -> Void {
        let url = BASE_URL + "v1/collections"
        let para = ["limit":"4","offset":"0"]
        
        manager.post(url, parameters: para, progress: nil, success: { (task, res) in
            let obj = JSON.init(data: res as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
            print("topObj:\(obj)")
            
            
            }) { (task, error ) in
                print("失败")
        }
    }

    //MARK: - CollectionView detegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryTopCollectionViewCell", for: indexPath)
        
        return topCell
        
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
