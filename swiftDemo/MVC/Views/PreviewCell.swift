//
//  PreviewCell.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/3.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit
import AssetsLibrary
class PreviewCell: UICollectionViewCell {
    
    var imageView:UIImageView?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() -> Void {
        self.imageView = UIImageView.init(frame: self.bounds);
        self.addSubview(self.imageView!);
    }
    
    func setCellWithData(model:ALAsset) -> Void {
        self.imageView?.image = UIImage.init(cgImage: model.thumbnail().takeUnretainedValue());
    }
}
