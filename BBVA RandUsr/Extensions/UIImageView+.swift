//
//  UIImageView+.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 30/06/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func shadow(shadowRadius:CGFloat, shadowOpacity:Float, shadowOffset:CGSize) {
        self.layer.masksToBounds = false
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    
    func bottomCurveS() {
        let maskLayer = CAShapeLayer(layer: self.layer)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x:0, y:0))
        bezierPath.addLine(to: CGPoint(x:self.bounds.size.width, y:0))
        bezierPath.addLine(to: CGPoint(x:self.bounds.size.width, y:self.bounds.size.height-75))
        bezierPath.addCurve(to: CGPoint(x:0, y:self.bounds.size.height), controlPoint1: CGPoint(x:self.bounds.size.width-250, y:self.bounds.size.height-90), controlPoint2: CGPoint(x:250, y:self.bounds.size.height))
        bezierPath.addLine(to: CGPoint(x:0, y:0))
        bezierPath.close()
        maskLayer.path = bezierPath.cgPath
        maskLayer.frame = self.bounds
        maskLayer.masksToBounds = true
        self.layer.mask = maskLayer
    }
    
}
