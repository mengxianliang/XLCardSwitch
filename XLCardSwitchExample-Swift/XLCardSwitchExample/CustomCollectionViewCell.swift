//
//  CustomCollectionViewCell.swift
//  XLCardSwitchExample
//
//  Created by MengXianLiang on 2019/8/28.
//  Copyright © 2019 mxl. All rights reserved.
//  自定义cell

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var textLabel = UILabel()
    var imageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI() {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        backgroundColor = UIColor.white
        
        let imageH = bounds.size.height*0.8
        let labelH = bounds.size.height*0.2
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: imageH)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        addSubview(imageView)
        
        
        textLabel.frame = CGRect(x: 0, y: imageH, width: bounds.size.width, height: labelH)
        textLabel.textColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
        textLabel.font = UIFont.systemFont(ofSize: 22)
        textLabel.textAlignment = NSTextAlignment.center;
        textLabel.adjustsFontSizeToFitWidth = true;
        addSubview(textLabel)
    }
    
}
