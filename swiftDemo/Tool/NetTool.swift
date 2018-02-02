//
//  NetTool.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

typealias sucess = ((AnyObject)->());
typealias failure = ((Error)->());

class NetTool: NSObject {
    
    // MARK: httpRequest
    class func innerRequestWithConfig(urlStr:String,params:NSDictionary?,sucess:@escaping sucess,failure:@escaping failure) -> URLSessionDataTask {
        let urlRequest = URLRequest.init(url: URL.init(string: urlStr)!, cachePolicy: URLRequest.CachePolicy.init(rawValue: 0)!, timeoutInterval: 10);
        var task:URLSessionDataTask = URLSession.shared.dataTask(with: urlRequest as!URLRequest) { (data, response, error) in
            if error == nil {
                /*let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments);*/
                let json = self.trsformToJSon(data: data as! AnyObject);
                sucess(json as AnyObject);
            } else {
                failure(error!);
            }
        }
        task.resume();
        return task ;
    }
    
    // MARK: 转json
     class func trsformToJSon(data:AnyObject) -> NSDictionary? {
        if data.isKind(of:NSData.classForCoder()) {
            //data
            let json = try? JSONSerialization.jsonObject(with: data as!Data, options: JSONSerialization.ReadingOptions.allowFragments);
            return json as! NSDictionary;
        } else {
            if data.isKind(of: NSString.classForCoder()) {
                //Str
                let strData = (data as!String).data(using: String.Encoding.utf8);
                let json = try? JSONSerialization.jsonObject(with: strData!, options: JSONSerialization.ReadingOptions.allowFragments);
                return json as! NSDictionary;
            } else if data.isKind(of: NSDictionary.classForCoder()) {
                //json
                return data as!NSDictionary;
            }
        }
        return nil;
    }
}
