//
//  NVActivityIndicatorAnimationPacman.swift
//  NVActivityIndicatorViewDemo
//
//  Created by Nguyen Vinh on 7/25/15.
//  Copyright (c) 2015 Nguyen Vinh. All rights reserved.
//

import UIKit

class NVActivityIndicatorAnimationPacman: NVActivityIndicatorAnimationDelegate {
    
    func setUpAnimationInLayer(layer: CALayer, size: CGSize, color: UIColor) {
        circleInLayer(layer, size: size, color: color)
        pacmanInLayer(layer, size: size, color: color)
    }
    
    func pacmanInLayer(layer: CALayer, size: CGSize, color: UIColor) {
        let pacmanSize = 2 * size.width / 3
        let pacmanDuration: CFTimeInterval = 0.5
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        // Stroke start animation
        let strokeStartAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        
        strokeStartAnimation.keyTimes = [0, 0.5, 1]
        strokeStartAnimation.timingFunctions = [timingFunction, timingFunction]
        strokeStartAnimation.values = [0.125, 0, 0.125]
        strokeStartAnimation.duration = pacmanDuration
        
        // Stroke end animation
        let strokeEndAnimation = CAKeyframeAnimation(keyPath: "strokeEnd")
        
        strokeEndAnimation.keyTimes = [0, 0.5, 1]
        strokeEndAnimation.timingFunctions = [timingFunction, timingFunction]
        strokeEndAnimation.values = [0.875, 1, 0.875]
        strokeEndAnimation.duration = pacmanDuration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [strokeStartAnimation, strokeEndAnimation]
        animation.duration = pacmanDuration
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        
        // Draw pacman
        let pacman = NVActivityIndicatorShape.Pacman.createLayerWith(size: CGSize(width: pacmanSize, height: pacmanSize), color: color)
        let frame = CGRect(
            x: (layer.bounds.size.width - size.width) / 2,
            y: (layer.bounds.size.height - size.height) / 2 + size.height / 2 - pacmanSize / 2,
            width: pacmanSize,
            height: pacmanSize
        )
        
        pacman.frame = frame
        pacman.addAnimation(animation, forKey: "animation")
        layer.addSublayer(pacman)
    }
    
    func circleInLayer(layer: CALayer, size: CGSize, color: UIColor) {
        let circleSize = size.width / 5
        let circleDuration: CFTimeInterval = 1
        
        // Translate animation
        let translateAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        
        translateAnimation.fromValue = 0
        translateAnimation.toValue = -size.width / 2
        translateAnimation.duration = circleDuration
        
        // Opacity animation
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.7
        opacityAnimation.duration = circleDuration
        
        // Animation
        let animation = CAAnimationGroup()
        
        animation.animations = [translateAnimation, opacityAnimation]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = circleDuration
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        
        // Draw circles
        let circle = NVActivityIndicatorShape.Circle.createLayerWith(size: CGSize(width: circleSize, height: circleSize), color: color)
        let frame = CGRect(
            x: (layer.bounds.size.width - size.width) / 2 + size.width - circleSize,
            y: (layer.bounds.size.height - size.height) / 2 + size.height / 2 - circleSize
                / 2,
            width: circleSize,
            height: circleSize
        )
        
        circle.frame = frame
        circle.addAnimation(animation, forKey: "animation")
        layer.addSublayer(circle)
    }
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com