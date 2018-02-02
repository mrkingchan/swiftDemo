//
//  CardVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

class CardVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView?;
    var dataArray:NSMutableArray?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.title = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "next", style: UIBarButtonItemStyle.plain, target: self, action:#selector(buttonAction));
        
        self.dataArray = NSMutableArray.init();
        for item in 0..<10 {
            self.dataArray?.add(String.init(format: "dataSource - %zd", item));
        }
        self.setUI();
    }
    
    // MARK: private Method
    @objc func buttonAction() {
        print(#function);
        let VC = NextVC.init(nibName: nil, bundle: nil);
        VC.complete = { object in
            print(object.classForCoder);
        }
        VC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(VC, animated: true);
    }
    // MARK: setUI
    func setUI() -> Void {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableViewStyle.plain);
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.tableFooterView = UIView.init();
        self.view .addSubview(tableView!);
    }
    
    // MARK: --UITableViewDataSource&Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArray?.count)!;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kcellID = "cellID";
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:kcellID);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: kcellID);
        }
        cell.textLabel?.text = self.dataArray![indexPath.row] as? String;
        return cell!;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            let contexual1 = UIContextualAction.init(style: UIContextualAction.Style.normal, title: "") { (action, subView, nil) in
                action.image = UIImage.init(named: "tabbar_1");
                subView.backgroundColor = UIColor.orange;
            }
            let contexual2 = UIContextualAction.init(style: UIContextualAction.Style.normal, title: "") { (action, subView, nil) in
                action.image = UIImage.init(named: "tabbar_2");
                subView.backgroundColor = UIColor.red;
            }
            let contexual3 = UIContextualAction.init(style: UIContextualAction.Style.normal, title: "") { (action, subView, nil) in
                action.image = UIImage.init(named: "tabbar_3");
                subView.backgroundColor = UIColor.blue;
            }
            let contexual4 = UIContextualAction.init(style: UIContextualAction.Style.normal, title: "") { (action, subView, nil) in
                action.image = UIImage.init(named: "tabbar_4");
                subView.backgroundColor = UIColor.green;
            }
            return UISwipeActionsConfiguration.init(actions: [contexual1,contexual2,contexual3,contexual4]);
    }
}
