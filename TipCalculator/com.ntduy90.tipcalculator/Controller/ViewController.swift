//
//  ViewController.swift
//  com.ntduy90.tipcalculator
//
//  Created by Duy Nguyen on 5/31/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackground()
        
        initNavigationBarStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
//        print("Did layout subviews")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View will appear")
    }
    
    @IBOutlet weak var background: UIView!
    
    func initBackground() {
        let backgroundLayer = applyGradient(colours: [HexColor("FCE38A")!, HexColor("F38181")!])
        
        background.backgroundColor = UIColor.clear
        
        background.layer.addSublayer(backgroundLayer)
    }
    
    func initNavigationBarStyle() {
        self.navigationController?
            .navigationBar
            .titleTextAttributes = [NSForegroundColorAttributeName : HexColor("808080", 0.8)!]
    }

    func applyGradient(colours: [UIColor]) -> CALayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = self.view.frame
        
        gradient.colors = colours.map { $0.cgColor }
        
        return gradient
    }

}

