//
//  AppDelegate.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SDVersion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UIAlertViewDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        let tt = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ttt");
        
        self.window?.rootViewController=tt
        let  time = DispatchTime.now()+Double(3 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) { 
            self.window?.rootViewController = ZKKTabbarController()
        }

        self.registerAPNSJPush(launchOptions);
        
        self.UMShare(launchOptions);

        return true
    }

    //极光推送
    func registerAPNSJPush(_ options: [AnyHashable: Any]?) -> Void{
        
        JPUSHService.register(forRemoteNotificationTypes: UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue | UIUserNotificationType.sound.rawValue, categories: nil);
        JPUSHService.setup(withOption: options, appKey: JpushAppKey, channel: nil, apsForProduction: true);
        
    }
    
    //获取APNs下发的DeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken);
        let sss = SDiOSVersion.deviceVersion().rawValue
        //        print("sss = \(sss)");
        JPUSHService.setTags([String(sss)], aliasInbackground: String(sss));
    }
    
    //接收到消息
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        JPUSHService.handleRemoteNotification(userInfo);
        
        if application.applicationState == UIApplicationState.active || application.applicationState == UIApplicationState.background {
            
            let aps = userInfo["aps"] as! NSDictionary;
            let content = aps["alert"] as! String;
            let alert = UIAlertView(title: "新消息", message: content, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "好");
            alert.show();
        } else {
            let aps = userInfo["aps"] as! NSDictionary;
            let content = aps["alert"] as! String;
            let alert = UIAlertView(title: "新消息", message: content, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "好");
            alert.show();
        }
    }
    
    //友盟分享
    func UMShare(_ option:[AnyHashable: Any]?) -> Void {
        UMSocialData.setAppKey(AppKey);
        UMSocialWechatHandler.setWXAppId(wechatAppID, appSecret: wechatAppSecret, url: JXZ);
        UMSocialQQHandler.setQQWithAppId(QQAppID, appKey: QQAppKey, url: JXZ);
        UMSocialSinaSSOHandler.openNewSinaSSO(withAppKey: SinaAppID, secret: SinaAppSecret, redirectURL: JXZ);
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        JPUSHService.resetBadge();
        UIApplication.shared.applicationIconBadgeNumber = 0;
    }
    

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

