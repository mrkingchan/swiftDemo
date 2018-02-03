//
//  PhotoVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/3.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit
import AssetsLibrary

class PhotoVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var lib:ALAssetsLibrary?;
    var collectionView:UICollectionView?;
    var dataArray:NSMutableArray?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataArray = NSMutableArray.init();
        self.view.backgroundColor = UIColor.white;
        
        
        self.navigationItem.title = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last;
        
        // MARK: loadData
        self.lib = ALAssetsLibrary.init();
        if ALAssetsLibrary.authorizationStatus() == ALAuthorizationStatus.denied {
            let alertController = UIAlertController.init(title: "相册权限被拒绝，请前往设置开启", message:nil , preferredStyle: UIAlertControllerStyle.alert);
            for _ in 0..<1 {
                let alertAction = UIAlertAction.init(title:"确定", style: UIAlertActionStyle.default) { action in
                    let settingUrl:URL = URL.init(string: UIApplicationOpenSettingsURLString)!;
                    if UIApplication.shared.canOpenURL(settingUrl) {
                        UIApplication.shared.openURL(settingUrl);
                    } else {
                        print("打开失败!");
                    }
                };
                alertController.addAction(alertAction);
            }
            self.present(alertController, animated: true, completion: nil);
        }
        
        // MARK: loadingView
        let loadingView = UIActivityIndicatorView.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width / 2 - 40, y: UIScreen.main.bounds.size.height / 2 - 40, width: 80, height: 80));
        loadingView.backgroundColor = UIColor.gray;
        loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        self.view.addSubview(loadingView);
        
        loadingView.startAnimating();
        
        // MARK: Lib
        self.lib?.enumerateGroups(withTypes: ALAssetsGroupType(ALAssetsGroupAll), using: { (group, stop) in
            if group != nil {
                group?.enumerateAssets({(asset, index, stop)->Void in
                    if asset != nil {
                      self.dataArray?.add(asset);
                    }
                });
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData();
                loadingView.stopAnimating();
            }
        }, failureBlock: { (error) in
            print(error?.localizedDescription);
        });
        
        // MARK: collectionView
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: (UIScreen.main.bounds.size.width - 20)/3 , height: (UIScreen.main.bounds.size.width - 20)/3);
        layout.minimumLineSpacing = 5.0;
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5);
        layout.minimumInteritemSpacing = 5.0;
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), collectionViewLayout: layout);
        self.collectionView?.backgroundColor = UIColor.white;
        self.collectionView?.delegate = self as! UICollectionViewDelegate;
        self.collectionView?.dataSource = self as! UICollectionViewDataSource;
        self.collectionView?.register(PhotoCell.classForCoder(), forCellWithReuseIdentifier: "cell");
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
        let cell:PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell;
        cell.setCellWithData(model: self.dataArray?.object(at: indexPath.row) as! ALAsset);
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = PreViewVC.init(nibName: nil, bundle: nil);
        VC.dataArray = self.dataArray;
        self.navigationController?.pushViewController(VC, animated: true);
    }
}
