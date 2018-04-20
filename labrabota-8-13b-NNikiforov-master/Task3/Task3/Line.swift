//
//  Line.swift
//  Task3
//
//  Created by Nikiforov Nikita on 4/18/18.
//  Copyright © 2018 Nikiforov Nikita. All rights reserved.
//

import Foundation
import UIKit

class Line {
    var start: CGPoint
    var end: CGPoint
    var color: UIColor
    var lWidth: CGFloat
    
    init(start: CGPoint, end: CGPoint, color: UIColor!, lWidth: CGFloat) {
        self.start = start
        self.end = end
        self.color = color
        self.lWidth = lWidth
    }
}
