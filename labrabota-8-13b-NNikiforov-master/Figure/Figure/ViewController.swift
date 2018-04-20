//
//  ViewController.swift
//  Figure
//
//  Created by Nikiforov Nikita on 4/14/18.
//  Copyright © 2018 Nikiforov Nikita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flower: CAShapeLayer!
    var trapeze: CAShapeLayer!
    var circle: CAShapeLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createFigure()
        
    }
 
    @IBAction func MoveAndRotateTapped(_ sender: Any) {
        let moveAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        moveAnimation.fromValue = flower.path
        flower.path = flowerPathWithCenter(center: CGPoint(x: 200, y:100), radius: CGFloat(50)).cgPath
        moveAnimation.toValue = flower.path
        moveAnimation.duration = 4
 
        //flower.add(moveAnimation, forKey: nil)
        
        
        let rotateAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        rotateAnimation.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = Double.pi
        rotateAnimation.duration = 4
        
        //flower.add(rotateAnimation, forKey: nil)
        
        let groupAnimations = CAAnimationGroup()
        groupAnimations.animations = [moveAnimation, rotateAnimation]
        flower.add(groupAnimations, forKey: nil)
    }
    
    @IBAction func ScaleTapped(_ sender: Any) {
        let scaleAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        scaleAnimation.valueFunction = CAValueFunction(name: kCAValueFunctionScaleX)
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 2
        scaleAnimation.duration = 4
        
        flower.add(scaleAnimation, forKey: nil)
    }
    @IBAction func BleachTapped(_ sender: Any) {
        let bleachAnimation = CABasicAnimation(keyPath: "opacity")
        bleachAnimation.fromValue = 1
        bleachAnimation.toValue = 0
        bleachAnimation.duration = 4
        
        flower.add(bleachAnimation, forKey: nil)
    }
    @IBAction func tap(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg1")!)
    }
    @IBAction func longPress(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2")!)
    }
    @IBAction func pinch(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg3")!)
    }
    @IBAction func rotation(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg4")!)
    }
    @IBAction func swipe(_ sender: Any) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg5")!)
    }
    
    
    func createFigure() {
        flower = CAShapeLayer()
        flower.path = flowerPathWithCenter(center: CGPoint(x: 200, y:400), radius: CGFloat(50)).cgPath
        flower.fillColor = UIColor.yellow.cgColor
        flower.shadowRadius = 4.0
        flower.shadowOpacity = 0.4
        flower.shadowOffset = CGSize.zero
        
        flower.frame = self.view.bounds
        self.view.layer.addSublayer(flower)
        
        
        trapeze = CAShapeLayer()
        trapeze.path = trapezePathWithCenter(startPoint: CGPoint(x:100 , y:100), averageLine: 100, height: 50).cgPath
        trapeze.fillColor = UIColor.blue.cgColor
        self.view.layer.addSublayer(trapeze)
        
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let path = UIBezierPath(ovalIn:frame)
        
        circle = CAShapeLayer()
        circle.frame = frame
        circle.path = path.cgPath
        circle.fillColor = UIColor.blue.cgColor
        
        let gardient = CAGradientLayer()
        gardient.frame = frame
        gardient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gardient.startPoint = CGPoint(x: 0, y: 1)
        gardient.endPoint = CGPoint(x: 1, y: 0)
        gardient.mask = circle
        
        self.view.layer.addSublayer(gardient)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flowerPathWithCenter(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let flowerPath = UIBezierPath();
      
        let r = radius * 1.17557 / 2
        flowerPath.addArc(withCenter: CGPoint(x: center.x, y: center.y - radius), radius: r, startAngle: CGFloat(144/180*Double.pi), endAngle: CGFloat(0.2*Double.pi), clockwise: true)
        flowerPath.addArc(withCenter: CGPoint(x:center.x + CGFloat(cos(Double.pi*0.1))*radius, y:center.y - CGFloat(sin(Double.pi*0.1))*radius), radius: r, startAngle: CGFloat(216/180*Double.pi), endAngle: CGFloat(108/180*Double.pi), clockwise: true)
        flowerPath.addArc(withCenter: CGPoint(x:center.x + CGFloat(cos(54/180*Double.pi))*radius, y:center.y + radius*CGFloat(sin(54/180*Double.pi))), radius: r, startAngle: -CGFloat(72/180*Double.pi), endAngle: CGFloat(Double.pi), clockwise: true)
        flowerPath.addArc(withCenter: CGPoint(x: center.x - CGFloat(cos(54/180*Double.pi))*radius, y: center.y + CGFloat(sin(54/180*Double.pi))*radius), radius: r, startAngle: 0, endAngle: CGFloat(252/180*Double.pi), clockwise: true)
        flowerPath.addArc(withCenter: CGPoint(x:center.x - CGFloat(cos(Double.pi*0.1))*radius, y:center.y - CGFloat(sin(Double.pi*0.1))*radius), radius: r, startAngle: CGFloat(72/180*Double.pi), endAngle: -CGFloat(36/180*Double.pi), clockwise: true)
        
        return flowerPath
    }

    func trapezePathWithCenter(startPoint: CGPoint, averageLine: CGFloat, height: CGFloat) -> UIBezierPath {
        let trapezePath = UIBezierPath();
        trapezePath.move(to: startPoint)
        trapezePath.addLine(to: CGPoint(x:startPoint.x + 1.2*averageLine ,y: startPoint.y))
        trapezePath.addLine(to: CGPoint(x:startPoint.x + 1.1*averageLine ,y: startPoint.y + height))
        trapezePath.addLine(to: CGPoint(x: startPoint.x + 0.1*averageLine , y: startPoint.y + height))
        trapezePath.close()
        return trapezePath
    }
}

