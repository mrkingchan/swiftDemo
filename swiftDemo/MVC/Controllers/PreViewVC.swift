
//
//  PreViewVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/3.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit
import AssetsLibrary

class PreViewVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var collectionView:UICollectionView?;
    var dataArray:NSMutableArray?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        
        let layout = UICollectionViewFlowLayout.init();
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
        layout.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        
        // MARK: UICollectionView
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: layout);
        self.collectionView?.delegate = self as!UICollectionViewDelegate;
        self.collectionView?.dataSource = self as! UICollectionViewDataSource;
        self.collectionView?.register(PreviewCell.classForCoder(), forCellWithReuseIdentifier: "cell");
        self.collectionView?.isPagingEnabled = true;
        self.view.addSubview(self.collectionView!);
    }
    
    // MARK: UICollectionViewDataSource&Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataArray?.count)!;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:PreviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PreviewCell;
        cell.setCellWithData(model: self.dataArray![indexPath.row] as! ALAsset);
        return cell;
    }
    
    // MARK: memeory management
    deinit {
        self.collectionView = nil;
    }
}
