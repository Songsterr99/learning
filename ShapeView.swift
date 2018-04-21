//
//  ShapeView.swift
//  task1
//
//  Created by fpmi on 21.04.2018.
//  Copyright © 2018 Dantes. All rights reserved.
//

import UIKit

@IBDesignable
class ShapeView: UIView {

    var path:UIBezierPath!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createFigure(){
        path = UIBezierPath(ovalIn: self.bounds)
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        path.close()
    }
    
    override func draw(_ rect: CGRect){
        self.createFigure()
        let mask = CAShapeLayer()
        mask.frame = path.bounds
        mask.path = path.cgPath
        
        let gradient = CAGradientLayer()
        gradient.frame = path.bounds
        gradient.colors = [UIColor.orange.cgColor, UIColor.red.cgColor]
        gradient.startPoint = CGPoint(x:0, y:1)
        gradient.endPoint = CGPoint(x:1, y:0)
        gradient.mask = mask
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        path.fill()
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
