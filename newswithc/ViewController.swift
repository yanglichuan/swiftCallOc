//
//  ViewController.swift
//  newswithc
//
//  Created by  yanglc on 15/12/1.
//  Copyright © 2015年  yanglc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sampleView: UIView!
    
    
    @IBOutlet weak var sw: AMViralSwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var x = MM();
        
        
        
        self.sw.animationElementsOn = [[ AMElementView: self.sampleView.layer,
            AMElementKeyPath: "backgroundColor",
            AMElementFromValue: UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1).CGColor,
            AMElementToValue: UIColor.whiteColor().CGColor]]
//        
//        self.sw.animationElementsOn = [
//        @{ AMElementView: self.sampleView.layer,
//        AMElementKeyPath: @"backgroundColor",
//        AMElementFromValue: (id)[UIColor colorWithRed:74.0/255.0 green:144.0/255.0 blue:226.0/255.0 alpha:1].CGColor,
//        AMElementToValue: (id)[UIColor whiteColor].CGColor }
//        ];
        
        
        
        
//        
//        self.sw.animationElementsOff = @[
//        @{ AMElementView: self.sampleView.layer,
//        AMElementKeyPath: @"backgroundColor",
//        AMElementToValue: (id)[UIColor colorWithRed:74.0/255.0 green:144.0/255.0 blue:226.0/255.0 alpha:1].CGColor,
//        AMElementFromValue: (id)[UIColor whiteColor].CGColor }
//        ];
//        
        
        
        
        self.sw.animationElementsOff = [[ AMElementView: self.sampleView.layer,
        AMElementKeyPath: "backgroundColor",
        AMElementFromValue: UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1).CGColor,
        AMElementToValue: UIColor.whiteColor().CGColor]]

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

