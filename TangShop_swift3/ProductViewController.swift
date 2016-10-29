//
//  ProductViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
class ProductViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

   var collectionView: UICollectionView!
    var  dataArr = [AnyObject]()
    
//    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.scoll
//        return <#value#>
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.loadData()
    }

    func  loadData() -> Void {
        let url = BASE_URL + "v2/items";
        let para = ["gender":"1","generation":"1","limit":"20","offset":"0"];
        
        BaseRequest.getWithURL(url, para: para as NSDictionary) { (data, error ) in
            if (error == nil) {
                
                let obj = JSON.init(data: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 7))
                print("obj:\(obj)")

                for item in obj["data"]["items"].arrayValue{
                    
                    let itemModel = item["data"]
                    let model = ProductMoel.init(jsonFrom: itemModel)
                    self.dataArr.append(model)
                }
                print((self.dataArr.first as! ProductMoel!).price)

                print("product:\(self.dataArr)")
                DispatchQueue.main.async(execute: { 
                    print((self.dataArr.first as! ProductMoel!).price)
                    
                    self.collectionView.reloadData()
                })
            }
        }
    }


    func setUI () -> Void {
        
        setNav()
        
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        self.view.addSubview(self.collectionView)
    }
    
    func  setNav() -> Void {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(searchAction))
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 242 / 255, green: 80 / 255, blue: 85 / 255, alpha: 1)
        
        self.navigationItem.title = "单品"
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = {[NSFontAttributeName: UIFont .systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.white]}()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func searchAction() -> Void {
    
        let  searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    
    //collectViewDetegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        let  model  = dataArr[indexPath.row]as! ProductMoel
        cell.setCellWithModel(model: model )
   
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (SCREEN_W-20)/2, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let proDetailVC = ProductDetailViewController()
        let model = dataArr[indexPath.row]
        proDetailVC.url = model.url
        self.navigationController?.pushViewController(proDetailVC, animated: true)
        
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
