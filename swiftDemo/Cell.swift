//
//  Cell.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/2.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    var productImage:UIImageView?;
    var titleLabel:UILabel?;
    var model:Model?;
    var complete:((String,UIImageView)->())?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.setUI();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setUI
    func setUI(){
        //Image
        self.productImage = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 80, height: 80));
        self.productImage?.clipsToBounds = true;
        self.productImage?.layer.cornerRadius = 5.0;
        self.addSubview(self.productImage!);
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(buttonAction(sender:)));
        self.productImage?.isUserInteractionEnabled = true;
        self.productImage?.addGestureRecognizer(tap);
        
        //titleLabel
        self.titleLabel = UILabel.init(frame: CGRect.init(x: 100, y: 35, width: UIScreen.main.bounds.size.width - 100, height: 30));
        self.titleLabel?.textColor = UIColor.blue;
        self.titleLabel?.textAlignment = NSTextAlignment.center;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.addSubview(self.titleLabel!);
    }
    
    @objc func buttonAction(sender:AnyObject) {
        if complete != nil {
            complete!((self.model?.titleStr!)!,self.productImage!);
        }
    }
    
    func setCellwithData(model:AnyObject){
        if (model.isKind(of: Model.classForCoder())) {
            let data = model as! Model;
            self.model = data;
            self.productImage?.image = UIImage.init(named: data.imageUrl!);
            self.titleLabel?.text = data.titleStr!;
        }
    }

}
