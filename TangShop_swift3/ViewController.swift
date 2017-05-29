//
//  ViewController.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ttImageView: UIImageView!
    var timer1: Timer!;
    var timer2: Timer!;
    override func viewDidLoad() {
        super.viewDidLoad()

        timer1 = Timer.scheduledTimer(timeInterval: 1.91, target: self, selector: #selector(self.stop), userInfo: nil, repeats: false);
        timer2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true);
		
		let  seg  = UISegmentedControl()
		seg.addTarget(self, action: #selector(actions(_:)), for: UIControlEvents.valueChanged)
    }
	
	func actions(_ actions:UISegmentedControl){
		
	}
    func stop() -> Void {
        timer2.invalidate();
        timer2 = nil;
    }
    //new 
    //new add 
    func action() -> Void {
        UIView.animate(withDuration: 1, animations: { 
            
            self.ttImageView.transform = self.ttImageView.transform.rotated(by: 1);
            
        }) 
    }

    


}

