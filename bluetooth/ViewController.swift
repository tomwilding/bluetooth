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
    
    var xs = [Double]()
    var ys = [Double]()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View")
        
        motionManager.deviceMotionUpdateInterval = 0.01
        
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
        var x = data.userAcceleration.x * -10000
        var y = data.userAcceleration.y * 10000
        if (abs(x) < 500) {
            x = 0        }
        if (abs(y) < 500) {
            y = 0
        }
        xs.append(x)
        ys.append(y)
    }
    
    func printArray(xs: [Double]) {
        for x in xs {
            println(x)
        }
    }
    
    @IBAction func redTapped(sender : AnyObject) {
        for x in xs {
            print("\(x),")
        }
        println()
        println()
        println()
        for y in ys {
            print("\(y),")
        }
    }


}

