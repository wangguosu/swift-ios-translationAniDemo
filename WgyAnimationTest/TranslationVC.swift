//
//  TranslationVC.swift
//  WgyAnimationTest
//
//  Created by wgyhello on 15/12/29.
//  Copyright © 2015年 fcqx. All rights reserved.
//

import UIKit

class TranslationVC: UIViewController,UIActionSheetDelegate {
    
    enum AniType: Int {
        case ViewCenterNone
        case ViewCenterAni
        case Block
        case Spring
        case LayerNone
        case CABasic
        case Display
        case Snap
        }
    
    var currentType:AniType? //当前动画的类型，因为我们要用多种方式实现
    var circleView:UIView?  //UIView 红色的圆 用于动画
    var layer:CALayer? // CALayer 蓝色的圆 用于动画
    
    var dynamicAnimator:UIDynamicAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentType = .Snap
        dynamicAnimator = UIDynamicAnimator()
        addView()
        addLayer()
        addOptionsBtn()
        addTapGesture()
    }
    
    //添加 UIView 的圆
    func addView(){
        circleView = UIView(frame: CGRectMake(0,0,50,50))
        self.view.addSubview(circleView!)
        circleView!.backgroundColor = UIColor.redColor()
        circleView?.layer.cornerRadius = 25
        circleView?.center = CGPoint(x: 30,y: 60)
    }
    
    //添加 Layer 的圆
    func addLayer(){
        layer = CALayer()
        layer?.bounds = CGRectMake(0, 0, 50, 50)
        layer?.cornerRadius = 25
        layer?.position = CGPoint(x: 30,y: 30)
        layer?.backgroundColor = UIColor.blueColor().CGColor
        self.view.layer.addSublayer(layer!)
    }
    
    //给主屏添加点击事件
    func addTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: "onTap:")
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    //根据动画类型匹配动画
    func onTap(tap:UITapGestureRecognizer){
        let local = tap.locationInView(self.view)
        switch(currentType!){
        case .ViewCenterNone:
            translationTypeViewCenterNone(local)
        case .ViewCenterAni:
            translationTypeViewCenterAni(local)
        case .Block:
            translationTypeBlock(local)
        case .Spring:
            translationTypeSpring(local)
        case .LayerNone:
            layerTypeNone(local)
        case .CABasic:
            layerTypeCABasic(local)
        case .Display:
            TypeDispaly(local)
        case .Snap:
            dynamicSnap(local)
        default:break
        }
    }
    
    //移动UIview 没有动画效果
    func translationTypeViewCenterNone(local:CGPoint){
        self.circleView?.center = local
    }
    
    //移动UIview 有动画效果
    func translationTypeViewCenterAni(local:CGPoint){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)
        self.circleView?.center = local
        UIView.commitAnimations()
    }
    
    //UIView.animate 封装的动画
    func translationTypeBlock(local:CGPoint){
       UIView.animateWithDuration(1.0, animations: { () -> Void in
        self.circleView?.center = local
        }) { (finished) -> Void in
            print("finished")
        }
    }
    
    //UIView Spring 弹簧动画
    //usingSpringWithDamping 阻尼系数 越小弹性越大
    //initialSpringVelocity 初始速度
    func translationTypeSpring(local:CGPoint){
        UIView.animateWithDuration(5 , delay: 0, usingSpringWithDamping: 0.43, initialSpringVelocity: 5, options: .CurveEaseOut ,animations: { () -> Void in
            self.circleView?.center = local
            }) { (finished) -> Void in
                print("end")
        }
    }
    
    //通过layer改变位置
    func layerTypeNone(local:CGPoint){
        self.layer?.position = local  // 蓝色的圆是有动画效果的
        self.circleView?.layer.position = local //红色的圆是没有动画效果的
    }
    
    //CABasicAnimation 改变layer的属性
    func layerTypeCABasic(local:CGPoint){
        let basicAni = CABasicAnimation(keyPath: "position") // 用position属性 来表示是位移动画
        basicAni.toValue = NSValue(CGPoint:local)
        basicAni.duration = 1.0//动画时间1秒
        layer?.addAnimation(basicAni, forKey: "")
        circleView?.layer.addAnimation(basicAni, forKey: "1")
    }
   
    //创建CADisplayLink
    var displaylink:CADisplayLink?
    func TypeDispaly(local:CGPoint){
        displaylink = CADisplayLink(target: self, selector: "onDisplayLink")
        displaylink!.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    //向下移动
    func onDisplayLink(){
        circleView?.layer.position.y++
        if circleView?.layer.position.y == self.view.frame.height - 30{
            displaylink?.paused = true
        }
    }

    //吸附动画
    func dynamicSnap(local:CGPoint){
        let snapBehavior = UISnapBehavior(item: circleView!, snapToPoint: local)//吸附动画 参数①要产生动画的view②被吸附到点
        snapBehavior.damping = 0.9
        dynamicAnimator?.removeAllBehaviors()
        dynamicAnimator?.addBehavior(snapBehavior)//dynamicAnimator物理学动画的执行者
    }
    
    
    func addOptionsBtn(){
        let btn = UIButton(frame: CGRectMake(0,0,100,60))
        btn.setTitle("动画方式", forState: .Normal)
        btn.setTitleColor(UIColor.redColor(), forState: .Normal)
        btn.addTarget(self, action: "onClick", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
        btn.center = CGPoint(x: UIScreen.mainScreen().bounds.width - 60 , y: UIScreen.mainScreen().bounds.width - 60)
    }
    
    func onClick(){
        showOptions()
    }
    
    //其他效果选项
    func showOptions(){
        let actionSheet = UIActionSheet()
        actionSheet.addButtonWithTitle("UIView无动画")
        actionSheet.addButtonWithTitle("UIview有动画")
        actionSheet.addButtonWithTitle("UIview.animate")
        actionSheet.addButtonWithTitle("弹簧动画")
        actionSheet.addButtonWithTitle("Layer实现")
        actionSheet.addButtonWithTitle("CABasic")
        actionSheet.addButtonWithTitle("逐帧动画")
        actionSheet.addButtonWithTitle("UIDynamicAnimator")
        actionSheet.delegate = self
        actionSheet.showInView(self.view)
    }
    

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch(buttonIndex){
        case 0:
            currentType = .ViewCenterNone
        case 1:
            currentType = .ViewCenterAni
        case 2:
            currentType = .Block
        case 3:
            currentType = .Spring
        case 4:
            currentType = .LayerNone
        case 5:
            currentType = .CABasic
        case 6:
            currentType = .Display
        case 7:
            currentType = .Snap
        default:
            break
        }
    }
    

}
