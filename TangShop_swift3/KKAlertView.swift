//
//  KKAlertView.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/19.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit

private var warningText: UILabel!
private var num = 0
private var timer: Timer!


class KKAlertView: NSObject {

    class func addKKAlertView(_ view: UIView, title: String) {
        
        let W  = UIScreen.main.bounds.size.width
        let H  = UIScreen.main.bounds.size.height
		
		
		
		
        warningText = UILabel.init(frame: CGRect(x: 0, y: 0, width: W/2, height: 30))
        warningText.center =  CGPoint(x: W/2, y: H/2-50)
        warningText.text = title
        warningText.textAlignment = .center
        warningText.textColor = UIColor.white
        warningText.backgroundColor = UIColor.init(white: 0.0, alpha: 0.7)
        warningText.layer.cornerRadius = 7.0
        warningText.clipsToBounds = true
        view.addSubview(warningText)
		
	
        
        func shakeToUpShow(_ aView: UIView){
            
            let animation = CAKeyframeAnimation(keyPath: "transform")
            animation.duration = 0.4
            let values = NSMutableArray()
            
            values.add(NSValue(caTransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)))
            values.add(NSValue(caTransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)))
            values.add(NSValue(caTransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)))
            values.add(NSValue(caTransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)))
            animation.values = values as [AnyObject]
            aView.layer.add(animation, forKey: nil)
        }
        
        func runTime(){
            
            timer = Timer.init(timeInterval: 0.5, target: self, selector: #selector(methodTime), userInfo: nil, repeats: true)
            if timer != nil{
                RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
            }
        }
        
        shakeToUpShow(warningText)
        runTime()
        
    }
    
    @objc fileprivate class func methodTime(){
        
        if num < 1 {
            num += 1
        }else{
            
            if  timer.isValid == true {
                timer.invalidate()
            }
            
            timer = nil
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(UIViewAnimationCurve.easeIn)
            UIView.setAnimationDuration(0.7)
            UIView.setAnimationDelegate(self)
            warningText.alpha = 0.0
            UIView.commitAnimations();
        }
    }
    
}
