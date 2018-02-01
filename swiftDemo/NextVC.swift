//
//  NextVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

class NextVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    var collectionView:UICollectionView?;
    var complete:((AnyObject)->Void)?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last;
        let layout = UICollectionViewFlowLayout.init();
        layout.minimumLineSpacing = 5.0;
        layout.minimumInteritemSpacing = 5.0;
        layout.itemSize = CGSize.init(width: Double((UIScreen.main.bounds.size.width - 10)/3.0), height: Double((UIScreen.main.bounds.size.width - 10)/3.0));
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64), collectionViewLayout: layout);
        self.collectionView?.delegate = self as! UICollectionViewDelegate;
        self.collectionView?.dataSource = self as! UICollectionViewDataSource;
        self.collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell");
        self.view .addSubview(self.collectionView!);
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(done));
    }
    
    @objc func done() {
        self.navigationController?.popViewController(animated: true);
        if complete != nil {
            complete!(self.collectionView!);
        }
    }
    // MARK: delegate&DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath);
//        cell.backgroundColor = UIColor.init(red: CGFloat(arc4random_uniform(255)/255), green: CGFloat(arc4random_uniform(255)/255), blue: CGFloat(arc4random_uniform(255)/255), alpha: 1.0);
        cell.backgroundColor = UIColor.orange;
        return cell!;
    }
    
}
