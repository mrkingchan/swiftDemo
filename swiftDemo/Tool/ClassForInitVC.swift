//
//  ClassForNewObject.swift
//  tableviewDemo
//
//  Created by Chan on 2017/9/15.
//  Copyright © 2017年 Chan. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    // MARK: 将String转为一个VC
   class func swiftClassFromString(className: String) -> UIViewController! {
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
