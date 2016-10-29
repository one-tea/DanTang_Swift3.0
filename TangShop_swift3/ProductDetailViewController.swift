//
//  ProductDetailViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/24.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import WebKit
class ProductDetailViewController: UIViewController,UIScrollViewDelegate {

    var url: String = ""
    
    var wk: WKWebView!
 
    var pro: UIProgressView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationItem.title = "详情"
        
        if (wk == nil){
            wk = WKWebView.init(frame: self.view.bounds)
            wk.scrollView.delegate = self
            let request = URLRequest.init(url: URL.init(string: url)!)
            wk.load(request)
            wk.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
            pro = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 50))
            pro.progress = 0.0
        
            wk.addSubview(pro)
            self.view.addSubview(wk)
        }


    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            pro.isHidden = wk.estimatedProgress == 1
            pro.setProgress(Float(wk.estimatedProgress), animated: true)
            
        }
    }
    
    deinit {
        
        wk.removeObserver(self, forKeyPath: "estimatedProgress");
        wk.scrollView.delegate = nil
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
