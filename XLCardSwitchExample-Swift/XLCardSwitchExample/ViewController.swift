//
//  ViewController.swift
//  XLCardSwitchExample
//
//  Created by MengXianLiang on 2019/8/27.
//  Copyright © 2019 mxl. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XLCardSwitchDataSource,XLCardSwitchDelegate {
    var cardSwitch: XLCardSwitch?
    var imageView: UIImageView?
    var blurEffectView: UIVisualEffectView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildUI()
    }

    func buildUI() {
        //添加其他部分
        self.buildOtherUI()
        //添加cardSwitch
        self.buildCardSwitch()
    }
    
    //自动布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageView?.frame = self.view.bounds
        self.blurEffectView?.frame = self.view.bounds
        self.cardSwitch?.frame = self.view.bounds
    }
    
    func buildOtherUI() -> () {
        //设置背景色
        self.view.backgroundColor = UIColor.white
        
        //设置navigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Previous", style: UIBarButtonItem.Style.plain, target: self, action: #selector(switchPrevious))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Next", style: UIBarButtonItem.Style.plain, target: self, action: #selector(switchNext))
        
        let seg = UISegmentedControl.init(items: ["正常滚动","自动居中"])
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(segMethod(seg:)), for: UIControl.Event.valueChanged)
        self.navigationItem.titleView = seg
        
        //背景图片
        self.imageView = UIImageView.init(frame: self.view.bounds)
        self.view.addSubview(self.imageView!)
        
        
        let blurEffect = UIBlurEffect.init(style: UIBlurEffect.Style.light)
        self.blurEffectView = UIVisualEffectView.init(effect: blurEffect)
        self.blurEffectView?.frame = self.imageView!.bounds
        self.imageView?.addSubview(blurEffectView!)
    }
    
    func buildCardSwitch() -> () {
        self.cardSwitch = XLCardSwitch.init()
        self.cardSwitch?.frame = self.view.bounds
        self.cardSwitch?.dataSource = self
        self.cardSwitch?.delegate = self
        //注册cell
        self.cardSwitch?.register(cellClass: CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        //添加到父视图
        self.view.addSubview(self.cardSwitch!)
    }
    
    //DataSource方法，返回总共卡片个数
    func cardSwitchNumberOfCard() -> (Int) {
        return 10
    }
    
    //DataSource方法，返回UICollectionViewCell
    func cardSwitchCellForItemAtIndex(index: Int) -> (UICollectionViewCell) {
        let cell = self.cardSwitch!.dequeueReusableCell(withReuseIdentifier:"CustomCollectionViewCell", for: index) as! CustomCollectionViewCell
        cell.imageView?.image = UIImage.init(named: self.imageNames()[index])
        cell.textLabel?.text = self.playerNames()[index]
        return cell
    }
    
    //代理方法
    func cardSwitchDidScrollToIndex(index: Int) {
        self.imageView?.image = UIImage.init(named: self.imageNames()[index])
    }
    
    func cardSwitchDidSelectedAtIndex(index: Int) {
        print("点击了卡片-\(index)")
    }
    
    //MARK-
    //MARK其他方法
    @objc func switchPrevious() -> () {
        self.cardSwitch?.switchPrevious()
    }
    
    @objc func switchNext() -> () {
        self.cardSwitch?.switchNext()
    }
    
    @objc func segMethod(seg: UISegmentedControl) -> () {
        self.cardSwitch?.pagingEnabled = (seg.selectedSegmentIndex == 1)
    }
    
    //MARK:-
    //MARK:数据源
    func imageNames() -> Array<String> {
        return ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    }
    
    func playerNames() -> Array<String> {
        return ["艾德·史塔克","凯瑟琳·徒利·史塔克","罗柏·史塔克","琼恩·雪诺","艾莉亚·史塔克","珊莎·史塔克","布兰·史塔克","瑟曦·兰尼斯特·拜拉席恩","提利昂·兰尼斯特","泰温·兰尼斯特","詹姆·兰尼斯特","乔佛里·拜拉席恩","丹尼莉丝·坦格利安"]
    }
}

