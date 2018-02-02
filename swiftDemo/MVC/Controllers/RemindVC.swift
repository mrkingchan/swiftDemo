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
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 49), style: UITableViewStyle.plain);
        self.tableView?.dataSource = self as UITableViewDataSource;
        self.tableView?.delegate = self as UITableViewDelegate;
        self.view.addSubview(self.tableView!);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addAction));
        
        self.dataArray = NSMutableArray.init();
//        self.loadData();
        // MARK:loadData
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
        
        /*NetTool.innerHttpRequestWithConfigure(httpMethod: "POST", urlStr: "http://www.1ecst.com/tp_ecst/index.php/Api2/Users/getRegion", params: "" as AnyObject, sucess: { (json) in
            let jsonDic :NSDictionary = json as! NSDictionary;
            self.dataArray?.addObjects(from: jsonDic.value(forKey: "regionName") as! [String]);
            DispatchQueue.main.async {
                self.tableView?.reloadData();
            }
        }) { (error) in
            print(error.localizedDescription);
        };*/
    }
    
    // MARK: addAction
    @objc func addAction() {
        let alertController = UIAlertController.init(title:"add", message:nil, preferredStyle: UIAlertControllerStyle.alert);
        alertController.addTextField { (tf) in
        }
        for index in 0..<1 {
            let alertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { action in
                let tf:UITextField = (alertController.textFields?.first)!;
                let content:String = tf.text!;
                if content.characters.count >= 1 {
                    self.dataArray?.add(alertController.textFields?.first?.text);
                    self.tableView?.reloadData();
                }
            };
            alertController.addAction(alertAction);
        }
        self.present(alertController, animated: true, completion: nil);
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
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "deleteAction";
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.dataArray?.removeObject(at: indexPath.row);
            self.tableView?.reloadData();
        }
    }
    
    // MARK: iOS11
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let contectAction = UIContextualAction.init(style: UIContextualAction.Style.normal, title: "delete", handler: { (action, subView, nil) in
                self.dataArray?.removeObject(at: indexPath.row);
                self.tableView?.reloadData();
            });
            let array:[UIContextualAction] = [contectAction];
            let swipAction = UISwipeActionsConfiguration.init(actions:array);
            return swipAction;
    }
    
    // MARK: right
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contection = UIContextualAction.init(style: UIContextualAction.Style.destructive, title:"delete") { (action, subView, nil) in
            self.dataArray?.removeObject(at: indexPath.row);
            self.tableView?.reloadData();
        }
        let swipAction = UISwipeActionsConfiguration.init(actions: [contection]);
        return swipAction;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = RemindDetailVC.init(nibName: nil, bundle: nil);
        VC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(VC, animated: true);
    }
}
