//
//  DIsplayLinkAniVC.swift
//  WgyAnimationTest
//
//  Created by wgyhello on 15/12/22.
//  Copyright © 2015年 fcqx. All rights reserved.
//

import UIKit

class DIsplayLinkAniVC: UIViewController {

    var layer:CALayer?
    var imgs:[UIImage] = []
    var index = 0
    override func viewDidLoad() {
        addImg()
    }
    
    func addImg(){
        //创建图像显示图层
        layer = CALayer()
        layer?.bounds = CGRectMake(0, 0, 87, 32)
        layer?.position = CGPoint(x: 160,y: 284)
        self.view.layer.addSublayer(layer!)
        
        //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
        imgs.append(UIImage(named: "tangwei")!)
        imgs.append(UIImage(named: "gaoyuanyuan1")!)
        imgs.append(UIImage(named: "gaoyuanyuan2")!)
        
        //定义时钟对象
        let display = CADisplayLink(target: self, selector: Selector("onDisplayLink"))
        //添加时钟对象到主运行循环
        display.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    
    var s = 0
    func onDisplayLink(){
        print("displaylink")
        if s++ % 20 == 0 {
            layer?.contents = imgs[index].CGImage
            index = (index + 1)%3
        }
    }
}
