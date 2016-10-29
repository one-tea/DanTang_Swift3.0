//
//  HomePageViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import MJRefresh
class HomePageViewController: UIViewController ,UIScrollViewDelegate{
    
    var scrollView = UIScrollView()
    var sliderView:UIView!
    var j  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNav()
        self.creatTopView()
        self.creatUI()
    
    
    }

    func setNav(){
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
        navigationController?.navigationBar.shadowImage=UIImage()
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 242 / 255, green: 80 / 255, blue: 85 / 255, alpha: 1)//背景色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent//状态栏
        self.automaticallyAdjustsScrollViewInsets=false
        self.navigationItem.title = "首页"
        
//        let imageView = UIImageView(image: UIImage(named:"header"))
//        self.navigationItem.titleView = imageView;
//        
        self.navigationController?.navigationBar.titleTextAttributes = {[NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName: UIColor.white]}()
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title:"",style: .plain, target:nil,action:nil)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:UIBarButtonSystemItem.search, target: self, action: #selector(self.search))
       
        //Nav上按钮文字或图片颜色
        self.navigationController?.navigationBar.tintColor=UIColor.white
 
    }
    
    func search(){
        //searching VC
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(searchVC, animated: true)

    }
    
    func creatTopView() -> Void  {
        
        let topView = UIView.init(frame:CGRect(x: 0, y: 0, width: SCREEN_W, height: 30))
        topView.backgroundColor = UIColor.white
        self.view.addSubview(topView)
        
        let btnW = CGFloat((SCREEN_W - 7*20)/6)
        let btnH = CGFloat(28)
        sliderView = UIView.init(frame:CGRect(x: 20, y: 28, width: btnW, height: 2))
        sliderView.backgroundColor = BASE_COLOR
        
        topView.addSubview(sliderView)
        
        let nameArr = ["精选", "美食", "家居", "数码", "美物", "杂货"]
        
        for i in 0...5{
            let button = UIButton()
            button.frame = CGRect(x:CGFloat(i) * (btnW + 20)+20, y: 0, width: btnW, height: btnH)
            
            button.setTitle(nameArr[i], for: UIControlState())
            button.titleLabel?.font=UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
            if i == 0 {
                button.setTitleColor(BASE_COLOR, for: UIControlState())
                
            }else{
                button.setTitleColor(UIColor.black, for: UIControlState())
            }
            button.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
            button.tag = 100 + i
            topView.addSubview(button)
            
        }
    
    }
    func btnAction(_ button:UIButton) -> Void {
        
        self.colorAction(button)
        self.scrollView.setContentOffset(CGPoint(x: SCREEN_W * CGFloat(button.tag - 100), y:0), animated: true)
        
    }
    func colorAction(_ button:UIButton) -> Void {
        for i in 0...5 {
            let btn = self.view.viewWithTag(100+i) as! UIButton
            btn.setTitleColor(UIColor.black, for: UIControlState())
            
        }
        button.setTitleColor(BASE_COLOR, for: UIControlState())
        UIView.animate(withDuration: 0.25) { 
            self.sliderView.mj_x=button.mj_x
        }
    }
    func creatUI() -> Void {
        
        let JXVC = JingXuanViewController()
        JXVC.view.frame=CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H)
        let FVC  = FoodViewViewController()
        FVC.view.frame = CGRect(x: SCREEN_W, y: 0, width: SCREEN_W, height: SCREEN_H)
        let HVC = HouseViewController()
        HVC.view.frame = CGRect(x: SCREEN_W*2, y: 0, width: SCREEN_W, height: SCREEN_H)
        let DVC  = DigitalViewController()
        DVC.view.frame = CGRect(x: SCREEN_W*3, y: 0, width: SCREEN_W, height: SCREEN_H)
        let NVC = NiceViewController()
        NVC.view.frame = CGRect(x: SCREEN_W*4, y: 0, width: SCREEN_W, height: SCREEN_H)
        let GVC = GeneralViewController()
        GVC.view.frame = CGRect(x: SCREEN_W*5, y: 0, width: SCREEN_W, height: SCREEN_H)
        
        let controllers = [JXVC, FVC, DVC, NVC, GVC]
        for vc  in controllers {
            self.addChildViewController(vc)
        }
        scrollView.isPagingEnabled=true
        scrollView.delegate=self
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H)
        scrollView.contentSize = CGSize( width: SCREEN_W*6, height: SCREEN_H)
        for VC  in childViewControllers {
            scrollView.addSubview(VC.view)
        }
        self.view.insertSubview(scrollView, at: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        for i in 0...5 {
            let  button = self.view.viewWithTag(100+i) as! UIButton
            button.setTitleColor(UIColor.black, for: UIControlState())
        }
        let  a =  Int(self.scrollView.contentOffset.x / SCREEN_W)
        let button = self.view.viewWithTag(100 + a) as!UIButton
        button.setTitleColor(BASE_COLOR, for: UIControlState())
        UIView.animate(withDuration: 0.25,animations:{
            self.sliderView.mj_x = button.mj_x
        })
        j = a
        
        
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
