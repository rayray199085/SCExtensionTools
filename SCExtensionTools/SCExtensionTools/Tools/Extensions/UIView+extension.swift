//
//  UIView+extension.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 6/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import pop

extension UIView{
    
    /// Add pop alpha animation
    ///
    /// - Parameters:
    ///   - fromValue: init value
    ///   - toValue: final value
    ///   - duration: duration interval
    ///   - completionBlock: completionBlock 
    func addPopAlphaAnimation(fromValue: Double, toValue: Double, duration:CFTimeInterval,completionBlock:((POPAnimation?, Bool) -> Void)? = nil){
        let anim = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim?.fromValue = fromValue
        anim?.toValue = toValue
        anim?.duration = duration
        anim?.completionBlock = completionBlock
        pop_add(anim, forKey: nil)
    }
    
    
    /// Add pop vertical upward or downward animation
    ///
    /// - Parameters:
    ///   - fromValue: init value
    ///   - toValue: final value
    ///   - springBounciness: springBounciness [0-20] default 4
    ///   - springSpeed: springSpeed [0-20] default 12
    ///   - delay: delay time interval
    ///   - completionBlock: completionBlock
    func addPopVerticalAnimation(fromValue: CGFloat, toValue: CGFloat, springBounciness: CGFloat = 4, springSpeed: CGFloat = 12,delay: Double = 0, completionBlock:((POPAnimation?, Bool) -> Void)? = nil){
        let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        anim?.fromValue = fromValue
        anim?.toValue = toValue
        anim?.springBounciness = springBounciness
        anim?.springSpeed = springSpeed
        anim?.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        anim?.completionBlock = completionBlock
        layer.pop_add(anim, forKey: nil)
    }
    
    func addPopHorizontalAnimation(fromValue: CGFloat, toValue: CGFloat, springBounciness: CGFloat = 6, springSpeed: CGFloat = 12,delay: Double = 0, completionBlock:((POPAnimation?, Bool) -> Void)? = nil){
        let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
        anim?.fromValue = fromValue
        anim?.toValue = toValue
        anim?.springBounciness = springBounciness
        anim?.springSpeed = springSpeed
        anim?.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
        anim?.completionBlock = completionBlock
        layer.pop_add(anim, forKey: nil)
    }
    
    /// Add pop scaleXY animation
    ///
    /// - Parameters:
    ///   - fromValue: init scale
    ///   - toValue: final scale
    ///   - duration: duration
    ///   - completionBlock: completionBlock
    func addPopScaleAnimation(fromValue: CGFloat = 1, toValue: CGFloat, duration: CFTimeInterval,completionBlock: ((POPAnimation?, Bool) -> Void)? = nil){
        let anim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        anim?.fromValue = NSValue(cgPoint: CGPoint(x: fromValue, y: fromValue))
        anim?.toValue = NSValue(cgPoint: CGPoint(x: toValue, y: toValue))
        anim?.duration = duration
        anim?.completionBlock = completionBlock
        pop_add(anim, forKey: nil)
    }
}
extension UIView{
    // MARK: UIView实现动画
    func transitionAnimationWith(_ duration: Double, animationTransition transition:UIView.AnimationTransition, animationCurve: UIView.AnimationCurve){
        UIView.animate(withDuration: duration, animations: {
            UIView.setAnimationCurve(animationCurve)
            UIView.setAnimationTransition(transition, for: self, cache: true)
        })
    }
    
    func wiggle(){
        let wiggleAnim = CABasicAnimation(keyPath: "position")
        wiggleAnim.duration = 0.05
        wiggleAnim.repeatCount = 5
        wiggleAnim.autoreverses = true
        wiggleAnim.fromValue = CGPoint(x: self.center.x - 5, y: self.center.y)
        wiggleAnim.toValue = CGPoint(x: self.center.x + 5, y: self.center.y)
        layer.add(wiggleAnim, forKey: "position")
    }
    
    func dim(){
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 0.75
        }) { (finished) in
            UIView.animate(withDuration: 0.15, animations: {
                self.alpha = 1.0
            })
        }
    }
    
    func colorize(){
        let randomNumberArray = generateRandomNumbers(quantity: 3)
        let randomColor = UIColor(red: randomNumberArray[0]/255, green: randomNumberArray[1]/255, blue: randomNumberArray[2]/255, alpha: 1)
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = randomColor
        }
        )}
    
    private func generateRandomNumbers(quantity:Int) -> [CGFloat]{
        var randomNumberArray = [CGFloat]()
        for _ in 1...quantity{
            let randomNumber = CGFloat(arc4random_uniform(255))
            randomNumberArray.append(randomNumber)
        }
        return randomNumberArray
    }
}
