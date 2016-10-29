//
//  JXDetailViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/19.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import WebKit
class JXDetailViewController: UIViewController,UIScrollViewDelegate {
    
    var url:String!
    
    var coverUrl:String!
    var titleL: String!
    var imageView:String!
    var pro:UIProgressView!
    var shareMsg:String!
    

    let copyjxz = NotificationCenter.default
    

    lazy var wk : WKWebView = {
        let wk = WKWebView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H))
            wk.scrollView.delegate = self
        let request = URLRequest.init(url: URL.init(string: self.url)!)
            wk.load(request)
        return wk
    }()
    
    
    func copyUrl() -> Void {
        
        KKAlertView.addKKAlertView(self.wk, title: "已复制链接到粘贴板")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        copyjxz.addObserver(self, selector: #selector(copyUrl), name: NSNotification.Name(rawValue:"copy"), object: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(share))
        
        pro = UIProgressView(frame: CGRect(x: 0, y: 0, width: SCREEN_W, height: 50))
        pro.progress = 0.0
        
        wk.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        wk.addSubview(pro)
        self.view.addSubview(wk)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            
            pro.isHidden = wk.estimatedProgress == 1
            pro.setProgress(Float(wk.estimatedProgress), animated: true)
            
        }
    }
    
    deinit {
        wk.removeObserver(self, forKeyPath: "estimatedProgress");
//        copyjxz.removeObserver(self, forKeyPath: "copy");
        wk.scrollView.delegate = nil
    }
    
    func share() -> Void {
        
        let GSVC = GSViewController()
        GSVC.modalTransitionStyle = .crossDissolve
        GSVC.coverUrl = self.coverUrl;
        GSVC.shareMsg = self.shareMsg;
        GSVC.url = self.url;
        GSVC.titleL = self.titleL;
        let image = screenCoverView(view: self.view)
        GSVC.GSView = UIImageView(image:image)
    
        self.present(GSVC, animated: true, completion: nil)
        
    }
    
    //去屏幕 -> 蒙图
    func screenCoverView(view:UIView) -> UIImage {
        let rect = view.frame
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        self.navigationController?.view.layer.render(in:context!)
        let img  = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
        
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
