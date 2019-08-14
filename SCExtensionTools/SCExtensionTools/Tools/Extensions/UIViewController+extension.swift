//
//  UIViewController+extension.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 10/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

extension UIViewController{
    
    /// add notification to detect keyboard frame chage
    ///
    /// - Parameter selector: selector
    func addKeyboardWillChangeFrameNotification(selector: Selector){
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: UIApplication.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    /// remove keyboard frame change notification
    func removeKeyboardWillChangeFrameNotification(){
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    
    /// get keyboard height and animation duration
    ///
    /// - Parameter notification: notification from selector method
    /// - Returns: height, duration
    func getKeyboardHeightAndAnimationDuration(notification: Notification)->(height:CGFloat, duration: TimeInterval)?{
        guard let keyboardFrame = (notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? NSValue)?.cgRectValue,
            let duration = (notification.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? NSNumber)?.doubleValue else {
                return nil
        }
        return (keyboardFrame.height,duration)
    }
}
enum transitionType: String{
    case fade = "fade"
    case push = "push"
    case reveal = "reveal"
    case moveIn = "moveIn"
    case cube = "cube"
    case suckEffect = "suckEffect"
    case oglFlip = "oglFlip"
    case rippleEffect = "rippleEffect"
    case pageCurl = "pageCurl"
    case pageUnCurl = "pageUnCurl"
    case cameraIrisHollowOpen = "cameraIrisHollowOpen"
    case cameraIrisHollowClose = "cameraIrisHollowClose"
}

enum transitionSubType: String{
    case left = "fromLeft"
    case bottom = "fromBottom"
    case right = "fromRight"
    case top = "fromTop"
}
extension UIViewController{
    // MARK: CATransition动画实现
    func transitionWithType(_ duration: Double, type: transitionType,withSubType subType: transitionSubType,forView view:UIView){
        
        //创建CATransition对象
        let animation = CATransition()
        
        //设置运动时间
        animation.duration = duration
        
        //设置运动type
        animation.type = CATransitionType(rawValue: type.rawValue);
        
        if (!subType.rawValue.isEmpty) {
            
            //设置子类
            animation.subtype = CATransitionSubtype(rawValue: subType.rawValue);
        }
        
        //设置运动速度
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        view.layer.add(animation, forKey: "animation")
        
    }
    
    // MARK: UIView实现动画
    func animationWithView(_ duration: Double, view:UIView,withAnimationTransition transition:UIView.AnimationTransition){
        
        UIView.animate(withDuration: duration, animations: {
            
            UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
            UIView.setAnimationTransition(transition, for: view, cache: true)
            
        })
    }
}
