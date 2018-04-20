//
//  ViewController.swift
//  Task3
//
//  Created by Nikiforov Nikita on 4/18/18.
//  Copyright © 2018 Nikiforov Nikita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawingView: DrawingView!
    @IBOutlet weak var widthSelector: UISegmentedControl!
    @IBOutlet weak var colorSelector: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearTspped(){
        var tmpDrawingView: DrawingView = drawingView as DrawingView
        tmpDrawingView.lines = []
        tmpDrawingView.setNeedsDisplay()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(drawingView.bounds.size, drawingView.isOpaque, 0)
        drawingView.drawHierarchy(in: drawingView.bounds, afterScreenUpdates: false)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let data = UIImagePNGRepresentation(snapshot!){
            let filename = getDocumentsDirectory().appendingPathComponent("snap.png")
            print(filename)
            try? data.write(to: filename)
        }
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @IBAction func widthSelectorTapped(_ sender: Any) {
        var tmpDrawingView: DrawingView = drawingView as DrawingView
        var width: CGFloat!
        switch widthSelector.selectedSegmentIndex {
        case 0:
            width = 1
        case 1:
            width = 2
        case 2:
            width = 3
        case 3:
            width = 4
        case 4:
            width = 5
        default:
            width = 3
        }
        tmpDrawingView.lWidth = width
    }
    
    @IBAction func colorSelectorTapped(_ sender: Any) {
        var tmpDrawingView: DrawingView = drawingView as DrawingView
        var color: UIColor!
        switch colorSelector.selectedSegmentIndex {
        case 0:
            color = UIColor.black
        case 1:
            color = UIColor.red
        case 2:
            color = UIColor.green
        case 3:
            color = UIColor.blue
        case 4:
            color = UIColor.yellow
        default:
            color = UIColor.black
        }
        tmpDrawingView.drawColor = color
    }
}

