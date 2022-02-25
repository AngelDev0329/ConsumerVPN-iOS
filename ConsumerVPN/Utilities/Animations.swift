//
//  Animations.swift
//  ConsumerVPN
//
//  Created by Amir Nazari on 10/26/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import Foundation
import GLKit

var circleProgressLineLayer = CAShapeLayer()
var checkmarkLayer = CAShapeLayer()
var crossLayer = CAShapeLayer()

class Animations {
    /// Spinning circle animation
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - lineWidth: customizable line width (Default : 2.0)
    ///   - color: customizable color (Default : White)
    static func animateIndeterminateDialog(_ progressView : UIView, lineWidth : CGFloat = 2.0, color : UIColor = .white) {
        setupInfiniteCircle(progressView, lineWidth: lineWidth, color: color)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = -(Double.pi * 2.0 * 1.0)
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.infinity
        
        progressView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    static func setupInfiniteCircle(_ progressView : UIView, lineWidth : CGFloat = 2.0, color : UIColor = .white) {
        let circleRadius: CGFloat = progressView.frame.width / 2.0
        let centerPoint = CGPoint(x: circleRadius, y: circleRadius)
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: (circleRadius),
                                      startAngle: CGFloat(GLKMathDegreesToRadians(20.0)),
                                      endAngle: CGFloat(GLKMathDegreesToRadians(320.0)),
                                      clockwise: true)
        
        circleProgressLineLayer.path = circlePath.cgPath
        circleProgressLineLayer.strokeColor = color.cgColor
        circleProgressLineLayer.fillColor = nil
        circleProgressLineLayer.lineWidth = lineWidth
        
        progressView.layer.addSublayer(circleProgressLineLayer)
        circleProgressLineLayer.removeAllAnimations()
        progressView.layer.removeAllAnimations()
    }
    
    /// encryption animation
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - lineWidth: customizable line width (Default : 2.0)
    ///   - color: customizable color (Default : Green)
    ///   - encryptionType: determines which animation will be performed
    static func encryptionDashAnimation(_ progressView : UIView , lineWidth : CGFloat = 2.0, color : UIColor = .green, encryptionType: Int) {
        // AES 256 (secure) encryption type == 0
        // AES 128 (fast) encryption type == 1
        // check encryption type to choose which animation to display.
        if encryptionType == 1 {
            setupFastAnimationUI(progressView, lineWidth: lineWidth, color : color)
        } else {
            setupSecureAnimationUI(progressView, lineWidth: lineWidth, color : color)
        }
    }
    
    /// Animation pathing for secure encryption shield
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - lineWidth: customizable line width (Default : 2.0)
    ///   - color: customizable color (Default : Green)
    static func setupSecureAnimationUI(_ progressView : UIView, lineWidth : CGFloat = 2.0,color : UIColor = .green) {
        setupInfiniteCircle(progressView, lineWidth: lineWidth, color: color)
        
        let circleRadius: CGFloat = progressView.frame.width / 2.0
        let centerPoint = CGPoint(x: circleRadius, y: circleRadius)
        let circlePath = UIBezierPath()
        
        // Scale multiplier based on the animation reference image size. Reference Image (68px x 68px)
        let scaleMultiplier = progressView.frame.width / 68
        
        circleProgressLineLayer.lineCap = CAShapeLayerLineCap.round
        circleProgressLineLayer.lineJoin = CAShapeLayerLineJoin.round
        
        circlePath.move(to:CGPoint(x: circleRadius + (17 * scaleMultiplier), y: circleRadius))
        circlePath.addQuadCurve(to: CGPoint(x: circleRadius, y: circleRadius + (25 * scaleMultiplier)), controlPoint: CGPoint(x: circleRadius + (14 * scaleMultiplier), y: circleRadius + (14 * scaleMultiplier)))
        circlePath.addQuadCurve(to: CGPoint(x: circleRadius - (17 * scaleMultiplier), y: circleRadius), controlPoint: CGPoint(x: circleRadius - (14 * scaleMultiplier), y: circleRadius + (14 * scaleMultiplier)))
        circlePath.addQuadCurve(to: CGPoint(x: circleRadius - (18 * scaleMultiplier),y: circleRadius - (14 * scaleMultiplier)), controlPoint: CGPoint(x: circleRadius - (18.5 * scaleMultiplier),y: circleRadius - (10 * scaleMultiplier)))
        circlePath.addQuadCurve(to: CGPoint(x: circleRadius, y: circleRadius - (19 * scaleMultiplier)), controlPoint: CGPoint(x: circleRadius - (10 * scaleMultiplier), y: circleRadius - (13 * scaleMultiplier)))
        circlePath.addQuadCurve(to: CGPoint(x: circleRadius + (18 * scaleMultiplier),y: circleRadius - (14 * scaleMultiplier)), controlPoint: CGPoint(x: circleRadius + (10 * scaleMultiplier), y: circleRadius - (13 * scaleMultiplier)))
        circlePath.addLine(to: CGPoint(x: circleRadius + (23 * scaleMultiplier), y: circleRadius - (19 * scaleMultiplier)))
        circlePath.addArc(withCenter: centerPoint, radius: circleRadius, startAngle: CGFloat(GLKMathDegreesToRadians(320.0)), endAngle: CGFloat(GLKMathDegreesToRadians(355.0)), clockwise: false)
        
        circleProgressLineLayer.path = circlePath.cgPath
        
        progressView.layer.addSublayer(circleProgressLineLayer)
        
        progressView.layer.removeAllAnimations()
        circleProgressLineLayer.removeAllAnimations()
        
        animateSuccess(progressView, color : color)
    }
    
    /// Animation pathing for fast encryption lightning bolt
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - lineWidth: customizable line width (Default : 2.0)
    ///   - color: customizable color (Default : Green)
    static func setupFastAnimationUI(_ progressView : UIView, lineWidth : CGFloat = 2.0,color : UIColor = .green) {
        setupInfiniteCircle(progressView, lineWidth: lineWidth)
        
        let circleRadius: CGFloat = progressView.frame.width / 2.0
        let centerPoint = CGPoint(x: circleRadius, y: circleRadius)
        let circlePath = UIBezierPath()
        
        let scaleMultiplier = progressView.frame.width / 68
        
        circleProgressLineLayer.lineCap = CAShapeLayerLineCap.round
        circleProgressLineLayer.lineJoin = CAShapeLayerLineJoin.round
        
        circlePath.move(to: CGPoint(x: circleRadius + (12 * scaleMultiplier),
                                    y: circleRadius - (9 * scaleMultiplier)))
        circlePath.addLine(to: CGPoint(x: circleRadius + (6 * scaleMultiplier),
                                       y: circleRadius - (3 * scaleMultiplier)))
        circlePath.addLine(to: CGPoint(x: circleRadius + (18 * scaleMultiplier),
                                       y: circleRadius - (3 * scaleMultiplier)))
        circlePath.addLine(to: CGPoint(x: circleRadius - (14 * scaleMultiplier),
                                       y: circleRadius + (20 * scaleMultiplier)))
        circlePath.addLine(to: centerPoint)
        circlePath.addLine(to: CGPoint(x: circleRadius - (10 * scaleMultiplier),
                                       y: circleRadius))
        circlePath.addLine(to: CGPoint(x: circleRadius + (21 * scaleMultiplier),
                                       y: circleRadius - (26 * scaleMultiplier)))
        circlePath.addArc(withCenter: centerPoint, radius: circleRadius, startAngle: CGFloat(GLKMathDegreesToRadians(309.0)), endAngle: CGFloat(GLKMathDegreesToRadians(355.0)), clockwise: false)
        
        circleProgressLineLayer.path = circlePath.cgPath
        
        progressView.layer.addSublayer(circleProgressLineLayer)
        
        progressView.layer.removeAllAnimations()
        circleProgressLineLayer.removeAllAnimations()
        
        animateSuccess(progressView, color : color)
    }
    
    
    /// Run animation
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - color: customizable color (Default : Green)
    static func animateSuccess(_ progressView : UIView, color : UIColor = .green) {
        animateFullCircle(progressView, color: color)
        
        let checkmarkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkmarkAnimation.duration = 0.7
        checkmarkAnimation.isRemovedOnCompletion = false
        checkmarkAnimation.fillMode = CAMediaTimingFillMode.both
        checkmarkAnimation.fromValue = 0
        checkmarkAnimation.toValue = 1
        checkmarkAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        circleProgressLineLayer.add(checkmarkAnimation, forKey: "strokeEnd")
    }
    
    /// Error 'X' Animation
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - lineWidth: customizable line width (Default : 2.0)
    ///   - color: customizable color (Default : Red)
    static func errorXanimation(_ progressView : UIView, lineWidth : CGFloat = 2.0, color : UIColor = .red) {
        setupFullCircle(progressView,lineWidth: lineWidth, color: color)
        
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: (progressView.frame.width * 0.72),
                                   y: (progressView.frame.height * 0.27)))
        crossPath.addLine(to: CGPoint(x: (progressView.frame.width * 0.27),
                                      y: (progressView.frame.height * 0.72)))
        crossPath.move(to: CGPoint(x: (progressView.frame.width * 0.27),
                                   y: (progressView.frame.height * 0.27)))
        crossPath.addLine(to: CGPoint(x: (progressView.frame.width * 0.72),
                                      y: (progressView.frame.height * 0.72)))
        
        crossLayer = CAShapeLayer()
        crossLayer.path = crossPath.cgPath
        crossLayer.fillColor = nil
        crossLayer.strokeColor = color.cgColor
        crossLayer.lineWidth = lineWidth
        
        circleProgressLineLayer.lineCap = CAShapeLayerLineCap.round
        circleProgressLineLayer.lineJoin = CAShapeLayerLineJoin.round
        
        crossLayer.lineCap = CAShapeLayerLineCap.round
        crossLayer.lineJoin = CAShapeLayerLineJoin.round
        
        progressView.layer.addSublayer(circleProgressLineLayer)
        progressView.layer.addSublayer(crossLayer)
        
        circleProgressLineLayer.removeAllAnimations()
        progressView.layer.removeAllAnimations()
        crossLayer.removeAllAnimations()
        
        animateFullCircle(progressView, color: color)
    }
    
    /// Animation pathing for full circle
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - lineWidth: customizable line width (Default : 2.0)
    ///   - color: customizable color (Default : Green)
    static func setupFullCircle(_ progressView : UIView, lineWidth: CGFloat = 2.0, color : UIColor = .green) {
        let circleRadius: CGFloat = progressView.frame.height / 2.0
        let centerPoint = CGPoint(x: circleRadius, y: circleRadius)
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: (circleRadius),
                                      startAngle: CGFloat(GLKMathDegreesToRadians(-90.0)),
                                      endAngle: CGFloat(GLKMathDegreesToRadians(275.0)),
                                      clockwise: true)
        
        circleProgressLineLayer = CAShapeLayer()
        circleProgressLineLayer.path = circlePath.cgPath;
        circleProgressLineLayer.strokeColor = color.cgColor;
        circleProgressLineLayer.fillColor = UIColor.clear.cgColor
        circleProgressLineLayer.lineWidth = lineWidth;
    }
    
    /// Run animation
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - color: customizable color (Default : Green)
    static func animateFullCircle(_ progressView : UIView, color : UIColor = .green) {
        let circleAnimation = CABasicAnimation(keyPath: "strokeColor")
        circleAnimation.duration = 0.5
        circleAnimation.isRemovedOnCompletion = false
        circleAnimation.fillMode = CAMediaTimingFillMode.both
        circleAnimation.toValue = color.cgColor
        
        circleProgressLineLayer.add(circleAnimation, forKey: "appearance")
    }
    
    /// Animation pathing for fast encryption lightning bolt
    ///
    /// - Parameters:
    ///   - progressView: View to animate
    ///   - lineWidth: customizable line width (Default : 2.0)
    ///   - color: customizable color (Default : Green)
    static func checkmarkAnimation(_ progressView : UIView, lineWidth : CGFloat = 2.0,color : UIColor = .green) {
        setupInfiniteCircle(progressView, lineWidth: lineWidth)
        
        let circleRadius: CGFloat = progressView.frame.width / 2.0
        let centerPoint = CGPoint(x: circleRadius, y: circleRadius)
        let circlePath = UIBezierPath()
                
        circleProgressLineLayer.lineCap = CAShapeLayerLineCap.round
        circleProgressLineLayer.lineJoin = CAShapeLayerLineJoin.round
        
        circlePath.move(to: CGPoint(x: circleRadius - (circleRadius * 0.45), y: circleRadius))
        circlePath.addLine(to: CGPoint(x: circleRadius, y: circleRadius + (circleRadius * 0.45)))
        circlePath.addLine(to: CGPoint(x: (circleRadius + (circleRadius - lineWidth) * cos(CGFloat(GLKMathDegreesToRadians(320.0)))), y: (circleRadius + (circleRadius - lineWidth) * sin(CGFloat(GLKMathDegreesToRadians(320.0))))))
        circlePath.addArc(withCenter: centerPoint, radius: circleRadius - lineWidth, startAngle: CGFloat(GLKMathDegreesToRadians(320.0)), endAngle: CGFloat(GLKMathDegreesToRadians(20.0)), clockwise: false)
        
        circleProgressLineLayer.path = circlePath.cgPath
        
        progressView.layer.addSublayer(circleProgressLineLayer)
        
        progressView.layer.removeAllAnimations()
        circleProgressLineLayer.removeAllAnimations()
        
        animateSuccess(progressView, color : color)
    }
}

