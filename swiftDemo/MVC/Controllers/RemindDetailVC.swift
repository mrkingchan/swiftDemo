//
//  RemindDetailVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/2.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

protocol dataDelegate:NSObjectProtocol {
    func passValue(value:AnyObject);
}

class RemindDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate {
    weak var delegate:dataDelegate?;
    
    var tableView:UITableView?;
    var dataArray:NSMutableArray?;
    var animateImage:UIImageView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back));
        self.navigationItem.title = NSStringFromClass(self.classForCoder).components(separatedBy:".").last;
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableViewStyle.plain);
        self.tableView?.tableFooterView = UIView.init();
        self.tableView?.dataSource = self as! UITableViewDataSource;
        self.tableView?.delegate = self as! UITableViewDelegate;
        self.view.addSubview(self.tableView!);
        self.dataArray = NSMutableArray.init();
        DispatchQueue.global().async {
            for _ in 0..<100 {
                let value = Random.number(end:4).last;
                let model = Model.init();
                model.titleStr = "xxxxxxx";
                model.imageUrl = String.init(format: "tabbar_%zd", value!);
                self.dataArray?.add(model);
            }
            DispatchQueue.main.async {
                self.tableView?.reloadData();
            }
        }
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true);
        self.delegate?.passValue(value: self.dataArray!);
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
        var cell:Cell! = tableView.dequeueReusableCell(withIdentifier:kcellID) as? Cell;
        if cell == nil {
            cell = Cell.init(style: UITableViewCellStyle.value1, reuseIdentifier: kcellID);
        }
        cell.complete = { valueStr,proImageView in
            let rec = cell.convert(proImageView.frame, to: self.view);
            self.animateImage = UIImageView.init(frame: rec);
            self.animateImage?.image = proImageView.image;
            self.view.addSubview(self.animateImage!);
            // MARK: animationAction
            let beiziser = UIBezierPath.init();
            beiziser.move(to: CGPoint.init(x: rec.origin.x, y: rec.origin.y));
            beiziser.addQuadCurve(to: CGPoint.init(x: UIScreen.main.bounds.size.width * 0.7, y: UIScreen.main.bounds.size.height + 200), controlPoint:CGPoint.init(x: 0.6 * UIScreen.main.bounds.size.width, y: 0));
            //moveAnimation
            let moveAnimation = CAKeyframeAnimation.init(keyPath: "position");
            moveAnimation.repeatCount = 1;
            moveAnimation.isRemovedOnCompletion = false;
            moveAnimation.fillMode = kCAFillModeForwards;
            moveAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear);
            moveAnimation.path = beiziser.cgPath;
            moveAnimation.duration = 1.0;
            moveAnimation.delegate = self as CAAnimationDelegate;

            //rotateAniamtion
            let rotateAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z");
            rotateAnimation.repeatCount = Float(INT_MAX);
            rotateAnimation.fromValue = NSNumber.init(value: 0);
            rotateAnimation.toValue  = NSNumber.init(value: 2 * Double.pi);
            rotateAnimation.fillMode = kCAFillModeForwards;
            rotateAnimation.isRemovedOnCompletion = false;
            rotateAnimation.speed = 6.0;
            rotateAnimation.duration = 1.0;
            rotateAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear);
            
            //animationGroup
            let group = CAAnimationGroup.init();
            group.animations = [moveAnimation,rotateAnimation];
            group.repeatCount = 1;
            group.duration = 1.0;
            group.fillMode = kCAFillModeForwards;
            group.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut);
            group.autoreverses = false;
            group.isRemovedOnCompletion = false;
            self.animateImage?.layer.add(group, forKey: "animationGroup");
        };
       let model = dataArray?.object(at: indexPath.row) as? Model;
        cell?.setCellwithData(model: model!);
        return cell!;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    // MARK: CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.animateImage?.removeFromSuperview();
    }
    
    // MARK: memeory management
    deinit {
        
    }
}
