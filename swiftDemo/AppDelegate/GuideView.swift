//
//  GuideView.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/3.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

class GuideView: UIView {
    
    var images:NSArray?;
    var contentView:UIScrollView?;
    var pageControl:UIPageControl?;
    
    override init(frame:CGRect,images:NSArray) {
        super.init(frame: UIScreen.main.bounds);
        self.images = images;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setUI
    func setUI() -> Void {
        //scrollView
        self.contentView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height));
        self.contentView?.isPagingEnabled = true;
        let count:CGFloat = self.images?.count as!CGFloat;
        self.contentView?.contentSize = CGSize.init(width:CGFloat(count * UIScreen.main.bounds.size.width), height: 0);
        self.addSubview(self.contentView!);
        
        //pageControl
        self.pageControl = UIPageControl.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width / 2 - 60, y: UIScreen.main.bounds.size.height - 30, width: 120, height: 20));
        self.pageControl?.numberOfPages = (self.images?.count)!;
        self.pageControl?.backgroundColor = UIColor.clear;
        self.pageControl?.pageIndicatorTintColor = UIColor.white;
        self.pageControl?.currentPage = 0;
        self.pageControl?.currentPageIndicatorTintColor = UIColor.blue;
        self.addSubview(self.pageControl!);
    
        for item in self.images! {
            let index = self.images!.index(of: item);
//            let imageView:UIImageView = UIImageView.init(frame: CGRect.init(x: index * UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height));
        }
    }
}
