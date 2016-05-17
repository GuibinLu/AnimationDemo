//
//  FlodImageView.swift
//  AnimationDemo
//
//  Created by 路贵斌 on 16/5/17.
//  Copyright © 2016年 Author. All rights reserved.
//

import UIKit

class FlodImageView: UIImageView {
    lazy var topLayer:CALayer = {
       let layerT = CALayer()
        layerT.contentsScale = UIScreen.mainScreen().scale
        layerT.frame = CGRect(x: 0, y:self.frame.height/4.0, width: self.frame.width, height: self.frame.height/2.0)
        layerT.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        layerT.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 0.5)
        return layerT
    }()
    
    lazy var bottomLayer:CALayer = {
        let layerB = CALayer()
        layerB.contentsScale = UIScreen.mainScreen().scale
        layerB.frame = CGRect(x: 0, y: self.frame.height/2.0, width: self.frame.width, height: self.frame.height/2.0)
        layerB.contentsRect = CGRect(x: 0, y: 0.5, width: 1, height: 0.5)
        let shadomLayer = CAGradientLayer()
        shadomLayer.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor]
        shadomLayer.frame = layerB.bounds
        shadomLayer.opacity = 0.0
        layerB.setValue(shadomLayer, forKey: "shadom")
        layerB.addSublayer(shadomLayer)
        return layerB
    }()
    
    override var image:UIImage? {
        get{
            return super.image
        }
        set{
            if let img = newValue {
                bottomLayer.contents =  img.CGImage
                topLayer.contents =  img.CGImage
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        userInteractionEnabled = true
        layer.addSublayer(bottomLayer)
        layer.addSublayer(topLayer)
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
    }
    
    @objc private func pan(panG:UIPanGestureRecognizer) {
        let p = panG.translationInView(self)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/600.0
        let angle = -p.y / self.frame.height * CGFloat(M_PI)
        topLayer.transform = CATransform3DRotate(transform, angle, 1, 0, 0)
        let opcity = p.y / self.frame.height
        let shadomLayer = bottomLayer.valueForKey("shadom") as! CALayer
        shadomLayer.opacity = Float(opcity)
        
        if panG.state == .Ended {
            topLayer.transform = CATransform3DIdentity
            shadomLayer.opacity = 0.0
        }
    }
    
    
    
}
