//
//  ViewController.swift
//  WgyAnimationTest
//
//  Created by wgyhello on 15/12/22.
//  Copyright © 2015年 fcqx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var img:UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        addImg()
//        addLayer()
        addTapGesture()
//        addCircleImg()
    }
    
    func addCircleImg(){
        let cirlleImg = UIImageView(frame: CGRectMake(0,0, PHOTO_HEIGHT, PHOTO_HEIGHT))
        cirlleImg.image = UIImage(named: "tangwei")
        cirlleImg.layer.cornerRadius = 100
        cirlleImg.layer.masksToBounds = true
        cirlleImg.layer.borderColor = UIColor.blueColor().CGColor
        cirlleImg.layer.borderWidth = 2
        
        self.view.addSubview(cirlleImg)
    }
    
    func addLayer(){
    
        let layer = CALayer()
        layer.bounds = CGRectMake(0, 0, 20, 20)
        layer.backgroundColor = UIColor.blueColor().CGColor
        layer.cornerRadius = layer.bounds.width/2
        layer.position = CGPoint(x: 20,y: 70)
        layer.shadowColor = UIColor.redColor().CGColor
        layer.shadowOffset = CGSize(width: 2,height: 2)
        layer.shadowOpacity = 0.9
        layer.masksToBounds = true
        layer.contents = UIImage(named: "tangwei")?.CGImage
//        layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1, 0, 0)
//        layer.delegate = self
        self.view.layer.addSublayer(layer)
//        layer.setNeedsDisplay()
    }
    
    func addTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: "onTap:")
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    func onTap(tap:UITapGestureRecognizer){
        print("ontap")
        let local = tap.locationInView(self.view)
        let layer = self.view.layer.sublayers![0]
//        viewTranslation(local)
        viewFrameTranslation()
        
//        hidentranslationAni(local)
//pathBezierTranslationAni()
        
        //        pathTranslationAni()
        // 图层放缩
//        layer.position = local
//        if layer.bounds.width == 200{
//            layer.bounds = CGRectMake(0, 0, 100, 100)
//            layer.cornerRadius = layer.bounds.width/2
//        }else{
//            self.view.layer.sublayers![0].bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT)
//            layer.cornerRadius = layer.bounds.width/2
//        }
    }
    func hidentranslationAni(localposition:CGPoint){
        let layer = self.view.layer.sublayers![0]

        CATransaction.begin()
        CATransaction.setAnimationDuration(5)
        CATransaction.setCompletionBlock { () -> Void in
//            let cabasicAni = CAKeyframeAnimation(keyPath: "position")
            let key0 = NSValue(CGPoint:layer.position)
            let key1 = NSValue(CGPoint:CGPoint(x: 80, y: 220))
            let key2 = NSValue(CGPoint:CGPoint(x: 45, y: 300))
            let key3 = CGPoint(x: 55, y: 400)
            layer.position = key3
        }
//        let key1 = CGPoint(x: 80, y: 220)
//        let key2 = CGPoint(x: 45, y: 300)
//        let key3 = CGPoint(x: 55, y: 400)
//        layer.position = key1
//        layer.position = key2
//        layer.position = key3
       
        CATransaction.commit()
    }
    
    
    func translationAnimation(localposition:CGPoint){
        
        let cabasicAnimation = CABasicAnimation(keyPath: "position")
        cabasicAnimation.toValue = NSValue(CGPoint: localposition)
        
        //设置其他动画属性
        cabasicAnimation.duration = 5.0//动画时间5秒
//        cabasicAnimation.repeatCount = HUGE//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
        cabasicAnimation.removedOnCompletion = true//运行一次是否移除动画
        cabasicAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        cabasicAnimation.speed = 10
//        cabasicAnimation.timeOffset = 2
//        cabasicAnimation.autoreverses = true
        cabasicAnimation.setValue(NSValue(CGPoint: localposition), forKey: "positionvalue")
        cabasicAnimation.delegate = self
        
        let layer = self.view.layer.sublayers![0]

        layer.addAnimation(cabasicAnimation , forKey: "move")
    }
    
    func pathTranslationAni(){
        //2.设置关键帧,这里有四个关键帧
        let layer = self.view.layer.sublayers![0]

        let cabasicAni = CAKeyframeAnimation(keyPath: "position")
        
        let key0 = NSValue(CGPoint:layer.position)
        let key1 = NSValue(CGPoint:CGPoint(x: 80, y: 220))
        let key2 = NSValue(CGPoint:CGPoint(x: 45, y: 300))
        let key3 = NSValue(CGPoint:CGPoint(x: 55, y: 400))
        
        let values = [key0,key1,key2,key3]
        cabasicAni.values = values
        //设置其他属性
        cabasicAni.duration=8.0
        layer.addAnimation(cabasicAni, forKey: "keyani")
    }
    
    func pathBezierTranslationAni(){
        let layer = self.view.layer.sublayers![0]
        //1.创建关键帧动画并设置动画属性
        let keyAni = CAKeyframeAnimation(keyPath: "position")
        //绘制贝塞尔曲线
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, layer.position.x, layer.position.y);//移动到起始点
        CGPathAddCurveToPoint(path, nil, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
        keyAni.path = path;//设置path属性
        
        //设置其他属性
        keyAni.duration=8.0;
        layer.addAnimation(keyAni, forKey: "")
    }
    
    func addImg(){
        img = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        img!.center = CGPoint(x: 50,y: 64)
        img?.image = UIImage(named: "tangwei")
        img?.layer.cornerRadius = 50
        img?.layer.masksToBounds = true
        self.view.addSubview(img!)
    }
    
    func viewTranslation(localposition:CGPoint){
//      方法1：block方式
        UIView.animateWithDuration(5 , delay: 0, usingSpringWithDamping: 0.43, initialSpringVelocity: 1, options: .CurveEaseOut ,animations: { () -> Void in
//            self.img!.center = localposition
            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, (self.img?.layer.position.x)!, self.img!.layer.position.y);//移动到起始点
            CGPathAddCurveToPoint(path, nil, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
//            self.img!.layer.
            
            }) { (finished) -> Void in
                print("end")
        }
        //方法2：静态方法
        //开始动画
//        UIView.beginAnimations("KAni", context: nil)
//        UIView.setAnimationDuration(5.0)
//        [UIView beginAnimations:@"KCBasicAnimation" context:nil];
//        [UIView setAnimationDuration:5.0];
        //[UIView setAnimationDelay:1.0];//设置延迟
        //[UIView setAnimationRepeatAutoreverses:NO];//是否回复
        //[UIView setAnimationRepeatCount:10];//重复次数
        //[UIView setAnimationStartDate:(NSDate *)];//设置动画开始运行的时间
        //[UIView setAnimationDelegate:self];//设置代理
        //[UIView setAnimationWillStartSelector:(SEL)];//设置动画开始运动的执行方法
        //[UIView setAnimationDidStopSelector:(SEL)];//设置动画运行结束后的执行方法
//        img!.center = localposition
        
        
        //开始动画
//        UIView.commitAnimations()
    }
    
    func viewFrameTranslation(){
        UIView.animateKeyframesWithDuration(5.0, delay: 0, options: .LayoutSubviews , animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: { () -> Void in
                self.img!.center=CGPointMake(80.0, 220.0);
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.25, animations: { () -> Void in
                self.img!.center=CGPointMake(45.0, 300.0);
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.5, animations: { () -> Void in
                self.img!.center=CGPointMake(55.0, 400.0);
            })
            
            }) { (finished) -> Void in
                print("")
        }
        
      
    
    }
    
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let layer = self.view.layer.sublayers![0]
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        layer.position = (anim.valueForKey("positionvalue") as! NSValue).CGPointValue()
        CATransaction.commit()
    }
    
    
    let PHOTO_HEIGHT:CGFloat  = 200
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        CGContextSaveGState(ctx);
        
        //图形上下文形变，解决图片倒立的问题
//        CGContextScaleCTM(ctx, 1, -1);
//        CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT)
        
        let img = UIImage(named: "tangwei")
        //注意这个位置是相对于图层而言的不是屏幕
        CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), img!.CGImage)
        
        //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
        //    CGContextDrawPath(ctx, kCGPathFillStroke);
        
        CGContextRestoreGState(ctx);
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

