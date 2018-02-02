//
//  AppDelegate.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds);
        window?.backgroundColor = UIColor.white;
        let tabbarVC = TabbrVC.init(nibName: nil, bundle: nil);
        window?.rootViewController = tabbarVC;
        window?.makeKeyAndVisible();
        self.set3DTouch();
        return true;
    }

    // MARK: 3D Touch
    func set3DTouch() {
        let touch1 = UIApplicationShortcutItem.init(type:"1", localizedTitle: "location", localizedSubtitle:"subLocation", icon: UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.location), userInfo: nil);
        
        let touch2 = UIApplicationShortcutItem.init(type:"1", localizedTitle: "share", localizedSubtitle:"subShare", icon: UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.share), userInfo: nil);
        
        let touch3 = UIApplicationShortcutItem.init(type:"1", localizedTitle: "add", localizedSubtitle:"subAdd", icon: UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.add), userInfo: nil);
        
            let touch4 = UIApplicationShortcutItem.init(type:"1", localizedTitle: "search", localizedSubtitle:"subSearch", icon: UIApplicationShortcutIcon.init(type: UIApplicationShortcutIconType.search), userInfo: nil)
        
        UIApplication.shared.shortcutItems = [touch1,touch2,touch3,touch4];
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let itemStr = shortcutItem.localizedSubtitle;
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "name"), object: "this is a notificaiton", userInfo:[:]);
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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

