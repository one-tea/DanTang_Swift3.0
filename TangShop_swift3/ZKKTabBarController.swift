//
//  ZKKTabBarController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import Foundation

import UIKit

class ZKKTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent=false
        self.tabBar.tintColor = UIColor.init(red:242/255,green:80/255,blue:85/255,alpha:1)
        
        let homePageVC = HomePageViewController()
        let productVC = ProductViewController()
        let categoryVC = CategoryViewController()
        let sb = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "qqq")
        
        
        let homePageNC = UINavigationController.init(rootViewController:homePageVC)
        let productNC = UINavigationController.init(rootViewController:productVC)
        let categortNC = UINavigationController.init(rootViewController:categoryVC)
        let infoNC = UINavigationController.init(rootViewController:sb)
        
        homePageNC.tabBarItem.title="首页"
        productNC.tabBarItem.title="单品"
        categortNC.tabBarItem.title="分类"
        infoNC.tabBarItem.title="关于"
        
        homePageNC.tabBarItem.image = UIImage.init(named:"TabBar_home_23x23_")
        productNC.tabBarItem.image = UIImage.init(named:"TabBar_gift_23x23_")
    categortNC.tabBarItem.image=UIImage.init(named:"TabBar_category_23x23_")
        
        infoNC.tabBarItem.image=UIImage.init(named:"header")
        infoNC.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
        
        
        let controllers = [homePageNC,productNC,categortNC,infoNC]
        self.viewControllers=controllers;
  
        
    }
}
