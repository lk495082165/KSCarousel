//
//  KSCarousel.swift
//  SuperTrace_Swift
//
//  Created by 程强 on 16/11/9.
//  Copyright © 2016年 程强. All rights reserved.
//

import UIKit

class KSCarousel: UIView,UIScrollViewDelegate {

    var scrollView : UIScrollView
    var dataAry : NSArray
    var pageControl : UIPageControl
    var timer : Timer
    
    override init(frame: CGRect) {
        self.scrollView = UIScrollView.init(frame: frame)
        self.dataAry = NSArray();
        self.pageControl = UIPageControl.init(frame: CGRect.init(x: frame.size.width/2.0-80, y: frame.size.height-30, width: 160, height: 30))
        self.timer = Timer.init()
        super.init(frame: frame)
        self.addSubview(scrollView)
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.addSubview(pageControl)
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target:self, selector: #selector(KSCarousel.autoScroll), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataAry(ary:NSArray) -> Void {
        
        let count = ary.count

        if count != 1 {
            let tempAry = NSMutableArray.init(capacity: 0)
            tempAry.addObjects(from: ary as![Any])
            tempAry.insert(ary[count-1], at: 0)
            dataAry = tempAry
        }else{
            dataAry = ary
        }
        
        let width = Double(self.frame.size.width)
        let height = Double(self.frame.size.height)
        for index in 0...self.dataAry.count-1 {
            let _image = UIImage.init(named: self.dataAry[index] as! String)
            let _imgView = UIImageView.init(image: _image!)
            let frame = CGRect.init(x: width*Double(index), y: 0, width: width, height: height)
            _imgView.frame = frame
            self.scrollView.addSubview(_imgView)
        }
        self.scrollView.contentSize = CGSize.init(width: width*Double(self.dataAry.count), height: height)
        self.pageControl.numberOfPages = count
        self.pageControl.pageIndicatorTintColor = UIColor.darkGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.scrollView.contentOffset = CGPoint.init(x: width, y: 0)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer.invalidate()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let count = self.dataAry.count
        if count == 1{
            self.pageControl.currentPage = 0
            return;
        }
        let width = Double(self.frame.size.width)
        let offset = scrollView.contentOffset;
        let page = Int(Double(offset.x)/width)
        self.pageControl.currentPage = page-1
        if page == count-1{
            self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }else if page == 0{
            self.scrollView.setContentOffset(CGPoint.init(x: Double(count-1)*width, y: 0), animated: false)
        }
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target:self, selector: #selector(KSCarousel.autoScroll), userInfo: nil, repeats: true)
    }
    
    func autoScroll() -> Void {
        let width = Double(self.frame.size.width)
        let count = self.dataAry.count
        var page = self.pageControl.currentPage+1
        if page<count-1{
            self.scrollView.setContentOffset(CGPoint.init(x: Double(page+1)*width, y: 0), animated: true)
            self.pageControl.currentPage = page
            page += 1
        }else{
            self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
            self.pageControl.currentPage = 0
            self.scrollView.setContentOffset(CGPoint.init(x: width, y: 0), animated: true)
        }
    }
}
