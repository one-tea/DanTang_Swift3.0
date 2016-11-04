//
//  CategoryViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UIScrollViewDelegate,CategoryButtonDelegate,CategoryBotttomDelegate {



    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  navBar  = self.navigationController?.navigationBar
        navBar?.shadowImage = UIImage.init()
        navBar?.tintColor = UIColor.white
        navBar?.barTintColor = BASE_COLOR
        navBar?.titleTextAttributes = {[NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName:UIColor.white]}()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "分类"
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain , target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(search))
        
        setUI()
        
    }
    
    func search () -> Void {
        let search  = SearchViewController ()
        self.navigationController?.pushViewController(search, animated: true)
        
    }

    func setUI(){
		
		self.view.addSubview(scrollView)
		
		let topVC = CategoryTopViewController()
		self.addChildViewController(topVC)//先加入子控制器中一部分,可以点击事件 在加载view
		let topView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 135))
		topView.backgroundColor = UIColor.white
		topView.addSubview(childViewControllers[0].view)
		scrollView.addSubview(topVC.view)
		
		let  midView = CategoryMidView(frame: CGRect(x: 0, y: 150, width: SCREEN_W, height: 100))
		midView.delegate = self
		scrollView.addSubview(midView)
		
		let  bottomView = CategoryBottomView(frame: CGRect(x: 0, y: (midView.mj_y + midView.midVieHieght() + 16), width:SCREEN_W, height: SCREEN_H))
		bottomView.delegate = self
		
		scrollView.contentSize = CGSize(width: SCREEN_W, height:SCREEN_H + 64)
		scrollView.showsVerticalScrollIndicator = false
		scrollView.addSubview(bottomView)
		
		
    }
	
	// detegate
	
	internal func push(_ button: UIButton) {
		let categoryBtnDetailVC = CategoryMidDetailViewController()
		categoryBtnDetailVC.id = button.tag
		categoryBtnDetailVC.navigationItem.title = button.titleLabel?.text
		categoryBtnDetailVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(categoryBtnDetailVC, animated: true)
	}
	
	internal func pushM(_ button: UIButton) {
		let categoryBtnDetailVC = CategoryMidDetailViewController()
		categoryBtnDetailVC.id = button.tag
		categoryBtnDetailVC.navigationItem.title = button.titleLabel?.text
		categoryBtnDetailVC.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(categoryBtnDetailVC, animated: true)

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
