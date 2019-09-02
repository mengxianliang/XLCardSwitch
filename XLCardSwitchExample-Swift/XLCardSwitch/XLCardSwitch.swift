//
//  XLCardSwitch.swift
//  XLCardSwitchExample
//
//  Created by MengXianLiang on 2019/8/27.
//  Copyright © 2019 mxl. All rights reserved.
//

import UIKit

//滚动切换回调方法
typealias XLCardScollIndexChangeBlock = (Int) -> ()

//布局类
class XLCardSwitchFlowLayout: UICollectionViewFlowLayout {
    //卡片和父视图宽度比例
    let CARDWIDTHSCALE: CGFloat = 0.7
    //卡片和父视图高度比例
    let CARDHEIGHTSCALE: CGFloat = 0.8
    //滚动到中间的调方法
    var indexChangeBlock: XLCardScollIndexChangeBlock?
    
    override func prepare() {
        self.scrollDirection = UICollectionView.ScrollDirection.horizontal
        self.sectionInset = UIEdgeInsets(top: self.insetY(), left: self.insetX(), bottom: self.insetY(), right: self.insetX())
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemHeight())
        self.minimumLineSpacing = 5
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //获取cell的布局
        let originalAttributesArr = super.layoutAttributesForElements(in: rect)
        //复制布局,以下操作，在复制布局中处理
        var attributesArr: Array<UICollectionViewLayoutAttributes> = Array.init()
        for attr: UICollectionViewLayoutAttributes in originalAttributesArr! {
            attributesArr.append(attr.copy() as! UICollectionViewLayoutAttributes)
        }
        
        //屏幕中线
        let centerX: CGFloat =  (self.collectionView?.contentOffset.x)! + (self.collectionView?.bounds.size.width)!/2.0
        
        //最大移动距离，计算范围是移动出屏幕前的距离
        let maxApart: CGFloat  = ((self.collectionView?.bounds.size.width)! + self.itemWidth())/2.0
        
        //刷新cell缩放
        for attributes: UICollectionViewLayoutAttributes in attributesArr {
            //获取cell中心和屏幕中心的距离
            let apart: CGFloat = abs(attributes.center.x - centerX)
            //移动进度 -1~0~1
            let progress: CGFloat = apart/maxApart
            //在屏幕外的cell不处理
            if (abs(progress) > 1) {continue}
            //根据余弦函数，弧度在 -π/4 到 π/4,即 scale在 √2/2~1~√2/2 间变化
            let scale: CGFloat = abs(cos(progress * CGFloat(Double.pi/4)))
            //缩放大小
            attributes.transform = CGAffineTransform.init(scaleX: scale, y: scale)
            //更新中间位
            if (apart <= self.itemWidth()/2.0) {
                self.indexChangeBlock?(attributes.indexPath.row)
            }
        }
        return attributesArr
    }
    
    //MARK -
    //MARK 配置方法
    //卡片宽度
    func itemWidth() -> CGFloat {
        return (self.collectionView?.bounds.size.width)! * CARDWIDTHSCALE
    }
    
    //卡片高度
    func itemHeight() -> CGFloat {
        return (self.collectionView?.bounds.size.height)! * CARDHEIGHTSCALE
    }
    
    //设置左右缩进
    func insetX() -> CGFloat {
        let insetX: CGFloat = ((self.collectionView?.bounds.size.width)! - self.itemWidth())/2.0
        return insetX
    }
    
    //上下缩进
    func insetY() -> CGFloat {
        let insetY: CGFloat = ((self.collectionView?.bounds.size.height)! - self.itemHeight())/2.0
        return insetY
    }
    
    //是否实时刷新布局
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

//代理
@objc protocol XLCardSwitchDelegate: NSObjectProtocol {
    //滑动切换到新的位置回调
    @objc optional func cardSwitchDidScrollToIndex(index: Int) -> ()
    //手动点击了
    @objc optional func cardSwitchDidSelectedAtIndex(index: Int) -> ()
}

//数据源
@objc protocol XLCardSwitchDataSource: NSObjectProtocol {
    //卡片的个数
    func cardSwitchNumberOfCard() -> (Int)
    //卡片cell
    func cardSwitchCellForItemAtIndex(index: Int) -> (UICollectionViewCell)
}

//展示类
class XLCardSwitch: UIView ,UICollectionViewDelegate,UICollectionViewDataSource {
    //公有属性
    weak var delegate: XLCardSwitchDelegate?
    weak var dataSource: XLCardSwitchDataSource?
    var selectedIndex: Int?
    var pagingEnabled: Bool?
    //私有属性
    private var _collectionView: UICollectionView?
    private var _dragStartX: CGFloat?
    private var _dragEndX: CGFloat?
    private var _dragAtIndex: Int?
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    func buildUI() {
        let flowlayout = XLCardSwitchFlowLayout.init()
        _collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowlayout)
        _collectionView?.delegate = self
        _collectionView?.dataSource = self
        _collectionView?.backgroundColor = UIColor.clear
        _collectionView?.showsHorizontalScrollIndicator = false
        self.addSubview(_collectionView!)
        
        //添加回调方法
        flowlayout.indexChangeBlock = { (index) -> () in
            if self.selectedIndex != index {
                self.selectedIndex = index
                self.delegateUpdateScrollIndex(index: index)
            }
        }
        
        //预设属性值
        pagingEnabled = false
    }
    
    //MARK:自动布局
    override func layoutSubviews() {
        super.layoutSubviews()
        _collectionView?.frame = self.bounds
    }

    //MARK:-
    //MARK:CollectionView方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataSource?.cardSwitchNumberOfCard())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (self.dataSource?.cardSwitchCellForItemAtIndex(index: indexPath.row))!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //执行代理方法
        selectedIndex = indexPath.row
        self.scrollToCenterAnimated(animated: true)
        self.delegateSelectedAtIndex(index: indexPath.row)
    }
    
    //MARK:-
    //MARK:ScrollViewDelegate
    @objc func fixCellToCenter() -> () {
        if self.selectedIndex != _dragAtIndex {
            self.scrollToCenterAnimated(animated: true)
            return
        }
        //最小滚动距离
        let dragMiniDistance: CGFloat = self.bounds.size.width/20.0
        if _dragStartX! - _dragEndX! >= dragMiniDistance {
            self.selectedIndex! -= 1//向右
        }else if _dragEndX! - _dragStartX! >= dragMiniDistance {
            self.selectedIndex! += 1 //向左
        }
        
        let maxIndex: Int  = (_collectionView?.numberOfItems(inSection: 0))! - 1
        self.selectedIndex = self.selectedIndex! <= 0 ? 0 : self.selectedIndex
        
        self.selectedIndex = self.selectedIndex! >= maxIndex ? maxIndex : self.selectedIndex
        self.scrollToCenterAnimated(animated: true)
    }
    
    //滚动到中间
    func scrollToCenterAnimated(animated: Bool) -> () {
        _collectionView?.scrollToItem(at: IndexPath.init(row:self.selectedIndex!, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    //手指拖动开始
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if (!self.pagingEnabled!) {return}
        _dragStartX = scrollView.contentOffset.x
        _dragAtIndex = self.selectedIndex
    }
    
    //手指拖动停止
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!self.pagingEnabled!) {return}
        _dragEndX = scrollView.contentOffset.x
        //在主线程执行居中方法
        DispatchQueue.main.async {
            self.fixCellToCenter()
        }
    }
    
    //MARK:-
    //MARK:执行代理方法
    //回调滚动方法
    func delegateUpdateScrollIndex(index: Int) -> () {
        if self.delegate == nil {return}
        if (self.delegate?.responds(to: #selector(self.delegate?.cardSwitchDidScrollToIndex(index:))))! {
            self.delegate?.cardSwitchDidScrollToIndex?(index: index)
        }
    }
    
    //回调点击方法
    func delegateSelectedAtIndex(index: Int) -> () {
        if self.delegate == nil {return}
        if (self.delegate?.responds(to: #selector(self.delegate?.cardSwitchDidSelectedAtIndex(index:))))! {
            self.delegate?.cardSwitchDidSelectedAtIndex?(index: index)
        }
    }
    
    //MARK:-
    //MARK:切换位置方法
    func switchToIndex(index: Int) -> () {
        DispatchQueue.main.async {
            self.selectedIndex = index
            self.fixCellToCenter()
        }
    }
    
    //向前切换
    func switchPrevious() -> () {
        var targetIndex = self.selectedIndex! - 1
        targetIndex = targetIndex < 0 ? 0 : targetIndex
        self.switchToIndex(index: targetIndex)
    }
    
    //向后切换
    func switchNext() -> () {
        var targetIndex = self.selectedIndex! + 1
        let maxIndex = (self.dataSource?.cardSwitchNumberOfCard())! - 1
        targetIndex = targetIndex > maxIndex ? maxIndex : targetIndex
        
        self.switchToIndex(index: targetIndex)
    }
    
    //MARK:-
    //MARK:数据源相关方法
    open func register(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        _collectionView?.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func dequeueReusableCell(withReuseIdentifier identifier: String, for index: Int) -> UICollectionViewCell {
        return _collectionView! .dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(row: index, section: 0))
    }
}
