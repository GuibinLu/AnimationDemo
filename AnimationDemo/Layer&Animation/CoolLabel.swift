//
//  CoolLabel.swift
//  CL
//
//  Created by 贵斌 on 16/5/10.
//  Copyright © 2016年 Author. All rights reserved.
//

import UIKit

class CoolLabel: UILabel,NSLayoutManagerDelegate {

    let textStorage = NSTextStorage(string: "")
    let textLayoutManager = NSLayoutManager()
    let textContainer:NSTextContainer = NSTextContainer()
    
    var oldLayers:[CATextLayer] = []
    var newLayers:[CATextLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initStorage()
    }
    
    private func initStorage(){
        textStorage .addLayoutManager(textLayoutManager)
        textLayoutManager.addTextContainer(textContainer)
        textLayoutManager.delegate = self
        textContainer.size = bounds.size
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines  = numberOfLines
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initStorage()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initStorage()
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override var text:String?{
        
        get{
            return textStorage.string
        }
        
        set{
        if let newText  = newValue{
        let attributedText = NSMutableAttributedString(string: newText)
        let textRange = NSMakeRange(0, attributedText.length)
        let paragraphyStyle = NSMutableParagraphStyle()
        paragraphyStyle.alignment = textAlignment
        attributedText.setAttributes([NSFontAttributeName : font,NSParagraphStyleAttributeName:paragraphyStyle,NSForegroundColorAttributeName:self.textColor],range: textRange)
        self.attributedText = attributedText
        
        }
        }


    }
    
    override var attributedText:NSAttributedString!{
        
        get{
            return self.textStorage as NSAttributedString
        }
        set{
            
            for  subLayer in oldLayers {
                subLayer .removeFromSuperlayer()
                
            }
            oldLayers.removeAll(keepCapacity: false)
            oldLayers = Array(newLayers)
            textStorage.setAttributedString(newValue)
            startOldLayersAnimation { () -> () in
                
            }
            startNewLayersAnimation { () -> () in
                
            }
            
        }
        
    }
    ///确定了每个文字的visible region
    func layoutManager(layoutManager: NSLayoutManager, didCompleteLayoutForTextContainer textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
        setTextLayers()
    }
    
    ///拿到最新的排版之后为每个文字 以及 glyph rect 创建一个CATextLayer
    func setTextLayers(){
        newLayers.removeAll(keepCapacity: false)
        let wordRange = NSMakeRange(0, textStorage.length)
        let layoutRect = textLayoutManager.usedRectForTextContainer(textContainer)

        
        var index = 0
        let totoalCharacter = NSMaxRange(wordRange)
        while index < totoalCharacter{
            let glyphRange = NSMakeRange(index, 1)
            
            // glyphRange 和 characterRange location 是相同的,只是length 可能不一样 一个glyph 有时相当于两个字符
            
            //字符区间 一个字形可能对应多个字符
            let characterRange = textLayoutManager.characterRangeForGlyphRange(glyphRange, actualGlyphRange: nil)
            let textCon = textLayoutManager.textContainerForGlyphAtIndex(index, effectiveRange: nil)
            //字形边界
            var glyphRect = textLayoutManager.boundingRectForGlyphRange(glyphRange, inTextContainer: textCon!)
            
            ///从index这个字符开始测试 是不是会发生为了美观而减小间距 产生错位
            let keringRange = textLayoutManager.rangeOfNominallySpacedGlyphsContainingIndex(index)
            
            if  keringRange.location == index && keringRange.length > 1 {
                if newLayers.count > 1{
                    let previousLayer = newLayers[newLayers.count - 1]
                    var frame = previousLayer.frame
                    
                    frame.size.width += CGFloat( fabs(frame.size.width - glyphRect.size.width) );
                    previousLayer.frame = frame
                }
            }
            
//            print( "\(index)--\(newLayers.endIndex)--\(newLayers.count) \n newString --- " + textStorage.string + "\n characterRange ------ \(characterRange)" + "\n layourtRect --- \(layoutRect) \n--------glyphRect-------\(glyphRect)"  + "\n kerningRange --- \(keringRange) \n \(layer.frame)" )

            glyphRect.origin.y += (self.bounds.size.height/2)-(layoutRect.size.height/2)
            let textLayer = CATextLayer(frame:glyphRect,string:self.attributedText.attributedSubstringFromRange(characterRange))
            layer.addSublayer(textLayer)
            newLayers.append(textLayer)
            index += characterRange.length
            
        }
        
    }

    
    func startOldLayersAnimation(textAnimation:()->()){

        
        for textLayer in oldLayers {
            let duration = Double(arc4random()%100)/125.0 + 0.35
            let delay = Double(arc4random_uniform(100)/500)

            let distance = CGFloat(arc4random()%50) + 25.0
            let angle = CGFloat((Double(arc4random())/M_PI_2)-M_PI_4)
            var transform = CATransform3DMakeTranslation(0, distance, 0)
            transform = CATransform3DRotate(transform, angle, 0, 0, 1)

            let animation =  CABasicAnimation(keyPath: "transform")
            animation.toValue = NSValue(CATransform3D: transform)
            animation.beginTime = delay
            animation.duration = duration
            
            let animationO = CABasicAnimation(keyPath: "opacity")
            animationO.toValue = NSNumber(double: 0.0)
            animationO.beginTime = delay
            animationO.duration = duration
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [animation,animationO]
            
            animationGroup.fillMode = kCAFillModeForwards
            animationGroup.removedOnCompletion = false
            animationGroup.duration = delay + duration
            animationGroup.delegate = self
            animationGroup.setValue(textLayer, forKey: "textLayer")
            animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            textLayer.addAnimation(animationGroup, forKey: "transform")
            
        }
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if let textLayer =  anim.valueForKey("textLayer") as? CATextLayer {
            textLayer.removeFromSuperlayer()
        }
        
    }
    
    func startNewLayersAnimation(textAnimation:()->()){

        for textLayer in newLayers {
            let delay = Double(arc4random_uniform(100)/500) + 0.07
            let duration = Double(arc4random()%100)/125.0 + 0.35

            let animationO = CABasicAnimation(keyPath: "opacity")
            animationO.toValue = NSNumber(double: 1.0)
            animationO.duration = duration
            animationO.beginTime = delay
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [animationO]
            animationGroup.fillMode = kCAFillModeForwards
            animationGroup.removedOnCompletion = false
            animationGroup.duration = delay + duration
            animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            textLayer.addAnimation(animationGroup, forKey: nil)
        }
    }
    
    
}


extension CATextLayer {
    convenience init(frame:CGRect, string:NSAttributedString) {
        self.init()
        self.contentsScale = UIScreen.mainScreen().scale
        self.frame = frame
        self.string = string
        self.opacity = 0

    }
}

