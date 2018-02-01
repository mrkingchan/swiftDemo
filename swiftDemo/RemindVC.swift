//
//  RemindVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

class RemindVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?;
    var dataArray:NSMutableArray?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64), style: UITableViewStyle.plain);
        self.tableView?.dataSource = self as UITableViewDataSource;
        self.tableView?.delegate = self as UITableViewDelegate;
        self.view.addSubview(self.tableView!);
        
        self.dataArray = NSMutableArray.init();
//        self.loadData();
        NetTool.innerRequestWithConfig(urlStr:"http://www.1ecst.com/tp_ecst/index.php/Api2/Users/getRegion", params:nil, sucess: { (json) in
            print(json);
            let jsonDic:NSDictionary = json as! NSDictionary;
            self.dataArray?.addObjects(from: jsonDic.value(forKey: "regionName") as! [String]);
            //主线程刷新
            DispatchQueue.main.async {
                self.tableView?.reloadData();
            }
        }) { (error) in
            print(error);
        }
    }
    
    // MARK: loadData
    func loadData() -> Void {
        var task:URLSessionDataTask = URLSession.shared.dataTask(with: URLRequest.init(url: URL.init(string: "http://www.1ecst.com/tp_ecst/index.php/Api2/Users/getRegion")!, cachePolicy: URLRequest.CachePolicy.init(rawValue: 0)!, timeoutInterval: 10)) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments);
            print(json);
        }
        task.resume();
    }
    
    // MARK: UITableViewDataSource&Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kcellID = "cell";
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: kcellID);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: kcellID);
        }
        cell.textLabel?.text = self.dataArray?.object(at: indexPath.row) as? String;
        return cell;
    }
}
