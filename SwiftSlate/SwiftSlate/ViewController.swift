//
//  ViewController.swift
//  SwiftSlate
//
//  Created by Kyle Oba on 8/5/14.
//  Copyright (c) 2014 Pas de Chocolat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var observerLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var randomEquationLabel: UILabel!
    @IBOutlet weak var randomResultLabel: UILabel!
    
    var viewModel: ViewModel?
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Subscribe to signal created by text field input:
        usernameTextField
            .rac_textSignal()
            .subscribeNext {
                println("anonymous text: \($0)")
        }
        
        usernameTextField
            .rac_textSignal()
            .subscribeNext { (text: AnyObject!) in
                if let t = text as? String {
                    println("explicit text: \(text)")
                }
        }
        
        // Bind text file field input to label:
        usernameTextField.rac_textSignal() ~> RAC(statusLabel, "text")
        
        // Observe label, to update another label:
        RACObserve(self.statusLabel, "text") ~> RAC(observerLabel, "text")
        
        // Use button press as signal source:
        loginButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside)
            .subscribeNext {
                _ in
                println("Button pressed!")
        }

        // Update random number equation based on RACCommand:
        viewModel!.equation ~> RAC(randomEquationLabel, "text")
        randomButton.rac_command = viewModel!.randomNumberCommand
        
        // update result of equation based on property change:
        RACObserve(self.viewModel, "randomNum")
            .map { (x: AnyObject!) -> AnyObject! in
                return "= \(x)"
        } ~> RAC(self.randomResultLabel, "text")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

