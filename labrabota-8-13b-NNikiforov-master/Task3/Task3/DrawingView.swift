//
//  DrawingView.swift
//  Task3
//
//  Created by Nikiforov Nikita on 4/18/18.
//  Copyright © 2018 Nikiforov Nikita. All rights reserved.
//

import UIKit

class DrawingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var lines: [Line] = []
    var lastPoint: CGPoint!
    var drawColor = UIColor.black
    var lWidth: CGFloat = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = (touches.first as AnyObject).location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let newPoint = (touches.first as AnyObject).location(in: self)
        lines.append(Line(start: lastPoint, end: newPoint, color: drawColor, lWidth: lWidth))
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        context?.beginPath()
        context?.setLineWidth(lWidth)
        context?.setLineCap(.round)
        
        for line in lines {
            context!.setLineWidth(line.lWidth)
            context?.move(to: CGPoint(x: line.start.x, y: line.start.y))
            context?.addLine(to: CGPoint(x: line.end.x, y: line.end.y))
            context?.setStrokeColor(line.color.cgColor)
            context?.strokePath()
        }
    }

}
