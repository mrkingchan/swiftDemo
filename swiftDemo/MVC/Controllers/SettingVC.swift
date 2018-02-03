//
//  SettingVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

class SettingVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView:UICollectionView?;
    var dataArray:NSMutableArray?;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:NSStringFromClass(PhotoVC.classForCoder()).components(separatedBy: ".").last, style: UIBarButtonItemStyle.plain, target: self, action: #selector(goNext));
        // MARK: collectionView
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: Double((UIScreen.main.bounds.size.width - 10)/3.0), height: Double((UIScreen.main.bounds.size.width - 10)/3.0));
        layout.minimumLineSpacing = 5.0;
        layout.minimumInteritemSpacing = 5.0;
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 49), collectionViewLayout:layout);
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView?.delegate = self as UICollectionViewDelegate;
        self.collectionView?.dataSource = self as UICollectionViewDataSource;
        self.collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell");
        self.view.addSubview(self.collectionView!);
    }

    // MARK: private Method
    @objc func goNext() ->Void {
        let VC = PhotoVC.init(nibName: nil, bundle: nil);
        VC.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(VC, animated: true);
    }
    // MARK: UICollectionViewDataSource&delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath);
        cell.backgroundColor = UIColor.init(red: CGFloat(Double(Random.number(end: 255).first!)/255.0), green: CGFloat(Double(Random.number(end: 255).first!)/255.0), blue: CGFloat(Double(Random.number(end: 255).first!)/255.0), alpha: 1.0);
        return cell;
    }
}
