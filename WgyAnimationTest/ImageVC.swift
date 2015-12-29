//
//  ImageVC.swift
//  WgyAnimationTest
//
//  Created by wgyhello on 15/12/22.
//  Copyright © 2015年 fcqx. All rights reserved.
//

import UIKit

class ImageVC: UIViewController ,UIActionSheetDelegate {

    let cnt = 3  //图片数量
    var currentIndex = 0
    var img:UIImageView?
    
    var imgs:[UIImage] = [] //要展示的图片容器
    
    var transitionType = "rippleEffect"
    
    private(set) var isNext: Bool {
        get{
            return true
        }
        set {
            layerTransitionAnimation(newValue) //启动动画
        }
    }

    override func viewDidLoad() {
        addImageView()
        addOptionsBtn()
    }
    
    func addImageView(){
        //定义图片控件
        img = UIImageView(frame: self.view.bounds)
        img?.contentMode = .ScaleAspectFit
        img?.image = UIImage(named: "tangwei")
        self.view.addSubview(img!)
        //添加手势
        let leftSwipGesture = UISwipeGestureRecognizer(target: self, action: "onLeftSwipe:")
        leftSwipGesture.direction = .Left
        self.view.addGestureRecognizer(leftSwipGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: "onRightSwipe:")
        rightSwipeGesture.direction = .Right
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        imgs.append(UIImage(named: "tangwei")!)
        imgs.append(UIImage(named: "gaoyuanyuan1")!)
        imgs.append(UIImage(named: "gaoyuanyuan2")!)
    }
    
    func onLeftSwipe(gesture:UISwipeGestureRecognizer){
        isNext = true
    }
    
    func onRightSwipe(gesture:UISwipeGestureRecognizer){
        isNext = false
    }
    
    //转场动画
    func layerTransitionAnimation(isnext:Bool){
        //1.创建转场动画对象
        let transition = CATransition()
        //水波效果
        transition.type = transitionType
        //设置子类型
        if (isnext) {
            transition.subtype = kCATransitionFromRight
        }else{
            transition.subtype = kCATransitionFromLeft
        }
        transition.duration = 1.0
        img?.layer.addAnimation(transition, forKey: "")
        img?.image = getImage(isnext)
    }
    
    // 获取当前应该展示的图片
    func getImage(isnext:Bool)->UIImage{
        if (isnext) {
            currentIndex = (currentIndex+1)%cnt
        }else{
            currentIndex = (currentIndex-1+cnt)%cnt
        }
        return imgs[currentIndex]
    }
    
    func addOptionsBtn(){
        let btn = UIButton(frame: CGRectMake(0,0,100,60))
        btn.setTitle("动画效果", forState: .Normal)
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        btn.addTarget(self, action: "onClick", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        btn.center = CGPoint(x: UIScreen.mainScreen().bounds.width - 60 , y: 64)
    }
    
    func onClick(){
        showOptions()
    }
    
    //其他效果选项
    func showOptions(){
        let actionSheet = UIActionSheet()
        actionSheet.addButtonWithTitle("骰子效果")
        actionSheet.addButtonWithTitle("翻转效果")
        actionSheet.addButtonWithTitle("收缩效果")
        actionSheet.addButtonWithTitle("向上翻页效果")
        actionSheet.addButtonWithTitle("向下翻页效果")
        actionSheet.addButtonWithTitle("摄像头打开效果")
        actionSheet.addButtonWithTitle("摄像头关闭效果")
        actionSheet.addButtonWithTitle("水波效果")
        actionSheet.delegate = self
        actionSheet.showInView(self.view)
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch(buttonIndex){
        case 0:
            transitionType = "cube"
        case 1:
            transitionType = "oglFlip"
        case 2:
            transitionType = "suckEffect"
        case 3:
            transitionType = "pageCurl"
        case 4:
            transitionType = "pageUnCurl"
        case 5:
            transitionType = "cameralIrisHollowOpen"
        case 6:
            transitionType = "cameraIrisHollowClose"
        case 7:
            transitionType = "rippleEffect"
        default:
            break
        }
    }
    
}
