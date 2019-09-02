//
//  CustomCollectionViewCell.swift
//  XLCardSwitchExample
//
//  Created by MengXianLiang on 2019/8/28.
//  Copyright © 2019 mxl. All rights reserved.
//  自定义cell

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel = UILabel.init()
    var imageView: UIImageView = UIImageView.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }
    
    func initUI() -> () {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        let imageH = self.bounds.size.height*0.8
        let labelH = self.bounds.size.height*0.2
        
        
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: imageH)
        self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.imageView.layer.masksToBounds = true
        self.addSubview(self.imageView)
        
        
        self.textLabel.frame = CGRect(x: 0, y: imageH, width: self.bounds.size.width, height: labelH)
        self.textLabel.textColor = UIColor.init(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        self.textLabel.font = UIFont.systemFont(ofSize: 22)
        self.textLabel.textAlignment = NSTextAlignment.center;
        self.textLabel.adjustsFontSizeToFitWidth = true;
        self.addSubview(self.textLabel)
    }
    
}
