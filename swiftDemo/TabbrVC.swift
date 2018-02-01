//
//  TabbrVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

class TabbrVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        let cardVC = CardVC.init(nibName: nil, bundle: nil);
        cardVC.title = NSStringFromClass(CardVC.classForCoder()).components(separatedBy: ".").last;
        var navi1 = UINavigationController.init(rootViewController: cardVC);
        let item1 = UITabBarItem.init(title: NSStringFromClass(cardVC.classForCoder).components(separatedBy: ".").last, image: UIImage.init(named: "tabbar_1"), selectedImage: nil);
        navi1.tabBarItem = item1;
        
        let remindVC = RemindVC.init(nibName: nil, bundle: nil);
        remindVC.title = NSStringFromClass(remindVC.classForCoder).components(separatedBy: ".").last;
        var navi2 = UINavigationController.init(rootViewController: remindVC);
        let item2 = UITabBarItem.init(title: NSStringFromClass(remindVC.classForCoder).components(separatedBy: ".").last, image: UIImage.init(named: "tabbar_2"), selectedImage: nil);
        navi2.tabBarItem = item2;

        
        let mapVC  = MapVC.init(nibName: nil, bundle: nil);
        mapVC.title = NSStringFromClass(mapVC.classForCoder).components(separatedBy: ".").last;
        var navi3 = UINavigationController.init(rootViewController: mapVC);
        let item3 = UITabBarItem.init(title: NSStringFromClass(mapVC.classForCoder).components(separatedBy: ".").last, image: UIImage.init(named: "tabbar_3"), selectedImage: nil);
        navi3.tabBarItem = item3;
        
        let settingVC = SettingVC.init(nibName: nil, bundle: nil);
        settingVC.title = NSStringFromClass(settingVC.classForCoder).components(separatedBy: ".").last;
        var navi4 = UINavigationController.init(rootViewController: settingVC);
        let item4 = UITabBarItem.init(title: NSStringFromClass(settingVC.classForCoder).components(separatedBy: ".").last, image: UIImage.init(named: "tabbar_4"), selectedImage: nil);
        navi4.tabBarItem = item4;
        
        let naviArray:NSMutableArray = NSMutableArray.init(capacity: 4);
        naviArray.add(navi1);
        naviArray.add(navi2);
        naviArray.add(navi3);
        naviArray.add(navi4);
        self.viewControllers = naviArray as? [UIViewController];
        
    }
       /*let s1 = NSStringFromClass(CardVC.classForCoder()).components(separatedBy: ".").last;
       let s2 = NSStringFromClass(RemindVC.classForCoder()).components(separatedBy: ".").last;
        let s3 = NSStringFromClass(MapVC.classForCoder()).components(separatedBy: ".").last;
        let s4 = NSStringFromClass(SettingVC.classForCoder()).components(separatedBy: ".").last;

        let classNameArrray:[AnyClass] = [NSClassFromString(s1!)!,
                                          NSClassFromString(s2!)!,
                                          NSClassFromString(s3!)!,
                                          NSClassFromString(s4!)!
        ];
        
        var navis:NSMutableArray = NSMutableArray.init(capacity: 4);
        for i in 0..<classNameArrray.count{
            let viewControler = self.viewControllerWithConfigure(classNameArrray[i] as AnyClass, titleStr: NSStringFromClass(classNameArrray[i]) as NSString, normalImage: UIImage.init(named: "")!, selectedImage:UIImage.init(named: "")!) ;
            //导航VC
            let navi = UINavigationController.init(rootViewController: viewControler as UIViewController);
            navis.add(navi);
        }
        self.viewControllers = navis as? [UIViewController];
    }*/
    
    // MARK: getViewController
    func viewControllerWithConfigure(_ className:AnyClass,titleStr:NSString,normalImage:UIImage?,selectedImage:UIImage?) -> UIViewController{
        var nsobjectype : UIViewController.Type = className as! UIViewController.Type
        var viewController: UIViewController = nsobjectype.init(nibName: nil, bundle: nil);
        let item:UITabBarItem = UITabBarItem.init(title: titleStr as String, image: normalImage, selectedImage: selectedImage);
        item.title = titleStr.components(separatedBy: ".").last;
        viewController.tabBarItem  = item;
        return viewController;
    }
            
        
    // MARK: animation
    func animationWith(index:Int) -> Void {
        let views = NSMutableArray.init(capacity: 4);
        
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale");
        scaleAnimation.duration = 0.1;
        scaleAnimation.fromValue = NSNumber.init(value: 0.7);
        scaleAnimation.toValue = NSNumber.init(value: 1.3);
        scaleAnimation.repeatCount = 1;
        scaleAnimation.timingFunction = CAMediaTimingFunction.init(name:  kCAMediaTimingFunctionEaseInEaseOut);
        scaleAnimation.isRemovedOnCompletion = true;
        scaleAnimation.autoreverses = true;
    }
}
