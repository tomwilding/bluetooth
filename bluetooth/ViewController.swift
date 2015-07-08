//
//  ViewController.swift
//  bluetooth
//
//  Created by Tom Wilding on 04/07/2015.
//  Copyright (c) 2015 Tom Wilding. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    // Advertise the service
    let mouseService = MouseServiceManager()
    
    var xs = [Double]()
    var ys = [Double]()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mouseService.delegate = self
        print("View")
        
        motionManager.deviceMotionUpdateInterval = 0.001
        
        if motionManager.deviceMotionAvailable{
            let queue = NSOperationQueue()
            motionManager.startDeviceMotionUpdatesToQueue(queue, withHandler: {
                data, error in
                self.handleDeviceMotionUpdate(data)
            })
        } else {
            print("Accelerometer is not available")
        }
    }
    
    func handleDeviceMotionUpdate(data : CMDeviceMotion) {
        var x = data.userAcceleration.x * -100000
        var y = data.userAcceleration.y * 100000
        mouseService.sendX(x)
    }
    
    func printArray(xs: [Double]) {
        for x in xs {
            println(x)
        }
    }
    
    @IBAction func redTapped(sender : AnyObject) {
        self.changeColor(UIColor.redColor())
        mouseService.sendColor("red")
//        for x in xs {
//            print("\(x),")
//        }
//        println()
//        println()
//        println()
//        for y in ys {
//            print("\(y),")
//        }
    }
    
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }


}

extension ViewController : MouseServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: MouseServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in

        }
    }
    
    func colorChanged(manager: MouseServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            switch colorString {
            case "red":
                self.changeColor(UIColor.redColor())
            case "yellow":
                self.changeColor(UIColor.yellowColor())
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}

