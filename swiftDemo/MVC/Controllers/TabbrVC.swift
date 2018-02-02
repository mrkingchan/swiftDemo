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
        /*let cardVC = CardVC.init(nibName: nil, bundle: nil);
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
        self.viewControllers = naviArray as? [UIViewController];*/
        
    let classNameArrray:[AnyClass] = [CardVC.classForCoder(),
                                          RemindVC.classForCoder(),
                                          MapVC.classForCoder(),
                                          SettingVC.classForCoder()] ;
        let navis:NSMutableArray = NSMutableArray.init();
        for i in 0..<classNameArrray.count{
            let viewControler = self.viewControllerWithConfigure(classNameArrray[i] as AnyClass, titleStr: NSStringFromClass(classNameArrray[i]) as NSString, normalImage: UIImage.init(named:String.init(format: "tabbar_%d",i + 1))!, selectedImage:UIImage.init(named: String.init(format: "tabbar_%d", i + 1))!);
            //导航VC
            let navi = UINavigationController.init(rootViewController: viewControler as UIViewController);
            navis.add(navi);
        }
        self.viewControllers = navis as? [UIViewController];
    }
    // MARK: getViewController
    func viewControllerWithConfigure(_ className:AnyClass?,titleStr:NSString,normalImage:UIImage?,selectedImage:UIImage?) -> UIViewController{
        /*var nsobjectype : UIViewController.Type = className as! UIViewController.Type
        var viewController: UIViewController = nsobjectype.init(nibName: nil, bundle: nil);*/
        let viewController:UIViewController? = self.swiftClassFromString(className: NSStringFromClass(className!));
        let item:UITabBarItem = UITabBarItem.init(title: titleStr as String, image: normalImage, selectedImage: selectedImage);
        item.title = titleStr.components(separatedBy: ".").last;
        viewController?.tabBarItem  = item;
        return viewController!;
    }
            
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = self.tabBar.items?.index(of: item);
        self.animationWith(index: index!);
    }
    // MARK: animation
    func animationWith(index:Int) -> Void {
        let views = NSMutableArray.init(capacity: 4);
        let items:[UIView] = self.tabBar.subviews;
        for index in 0..<items.count {
            var item:UIView = items[index];
            print(item.classForCoder);
                if NSStringFromClass(item.classForCoder) == "UITabBarButton" {
                    views.add(item);
                }
            }
        //scaleAnimation
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale");
        scaleAnimation.duration = 0.1;
        scaleAnimation.fromValue = NSNumber.init(value: 0.7);
        scaleAnimation.toValue = NSNumber.init(value: 1.3);
        scaleAnimation.repeatCount = 1;
        scaleAnimation.timingFunction = CAMediaTimingFunction.init(name:  kCAMediaTimingFunctionEaseInEaseOut);
        scaleAnimation.isRemovedOnCompletion = true;
        scaleAnimation.autoreverses = true;
        let subView:UIView = views[index] as! UIView;
        subView.layer.add(scaleAnimation, forKey: "nil");
    }
    
    // MARK: viewController
    func swiftClassFromString(className: String) -> UIViewController! {
        // get the project name
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            //拼接控制器名
            let classStringName = "\(className)"
            //将控制名转换为类
            let classType = NSClassFromString(classStringName) as? UIViewController.Type
            if let type = classType {
                let newVC = type.init();
                return newVC;
            }
        }
        return nil;
    }
}
