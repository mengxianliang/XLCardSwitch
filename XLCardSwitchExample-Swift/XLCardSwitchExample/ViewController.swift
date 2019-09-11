//
//  ViewController.swift
//  XLCardSwitchExample
//
//  Created by MengXianLiang on 2019/8/27.
//  Copyright © 2019 mxl. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XLCardSwitchDataSource,XLCardSwitchDelegate {

    var imageView: UIImageView = UIImageView.init()
    var blurEffectView: UIVisualEffectView = UIVisualEffectView.init()
    
    lazy var cardSwitch: XLCardSwitch = {
        let temp = XLCardSwitch.init()
        temp.frame = self.view.bounds
        temp.dataSource = self
        temp.delegate = self
        //注册cell
        temp.register(cellClass: CustomCollectionViewCell.self, forCellWithReuseIdentifier:"CustomCellID")
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildUI()
    }

    func buildUI() {
        //添加其他部分
        self.buildOtherUI()
        //添加cardSwitch
        self.view.addSubview(self.cardSwitch)
    }
    
    //自动布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageView.frame = self.view.bounds
        self.blurEffectView.frame = self.view.bounds
        self.cardSwitch.frame = self.view.bounds
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
        
        //设置默认背景图片
        self.imageView.image = UIImage.init(named: self.cellInfoArr()[0].0)
        self.view.addSubview(self.imageView)

        let blurEffect = UIBlurEffect.init(style: UIBlurEffect.Style.light)
        self.blurEffectView.effect = blurEffect;
        self.blurEffectView.frame = self.imageView.bounds
        self.imageView.addSubview(blurEffectView)
    }
    
    //DataSource方法，返回总共卡片个数
    func cardSwitchNumberOfCard() -> (Int) {
        return self.cellInfoArr().count
    }
    
    //DataSource方法，返回UICollectionViewCell
    func cardSwitchCellForItemAtIndex(index: Int) -> (UICollectionViewCell) {
        let cell = self.cardSwitch.dequeueReusableCell(withReuseIdentifier:"CustomCellID", for: index) as! CustomCollectionViewCell
        cell.imageView.image = UIImage.init(named: self.cellInfoArr()[index].0)
        cell.textLabel.text = self.cellInfoArr()[index].1
        return cell
    }
    
    //代理方法
    //切换到了卡片
    func cardSwitchDidScrollToIndex(index: Int) {
        self.imageView.image = UIImage.init(named: self.cellInfoArr()[index].0)
    }
    //点击了卡片
    func cardSwitchDidSelectedAtIndex(index: Int) {
        print("点击了卡片-\(index)")
    }
    
    //MARK-
    //MARK其他方法
    @objc func switchPrevious() -> () {
        self.cardSwitch.switchPrevious()
    }
    
    @objc func switchNext() -> () {
        self.cardSwitch.switchNext()
    }
    
    @objc func segMethod(seg: UISegmentedControl) -> () {
        self.cardSwitch.pagingEnabled = (seg.selectedSegmentIndex == 1)
    }
    
    //MARK:-
    //MARK:测试数据 (图片名称，名字)
    func cellInfoArr() -> Array<(String, String)> {
        return [("1","艾德·史塔克"),("2","凯瑟琳·徒利·史塔克"),("3","罗柏·史塔克"),("4","琼恩·雪诺"),("5","艾莉亚·史塔克"),("6","珊莎·史塔克"),("7","布兰·史塔克"),("8","瑟曦·兰尼斯特·拜拉席恩"),("9","提利昂·兰尼斯特"),("10","泰温·兰尼斯特"),("11","詹姆·兰尼斯特"),("12","乔佛里·拜拉席恩"),("13","丹尼莉丝·坦格利安")]
    }
}

