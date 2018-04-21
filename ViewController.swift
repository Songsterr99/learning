//
//  ViewController.swift
//  task1
//
//  Created by fpmi on 21.04.2018.
//  Copyright © 2018 Dantes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width: CGFloat = 300.0
        let height: CGFloat = 180.0
        
        let shapeView = ShapeView(frame: CGRect(x: self.view.frame.size.width / 2 - width / 2, y: self.view.frame.size.height / 2 - height / 2, width: width, height: height))
        self.view.addSubview(shapeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

