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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField
            .rac_textSignal()
            .subscribeNext { (text: AnyObject!) in
                if let t = text as? String {
                    println("text: \(text)")
                }
        }
        
        usernameTextField.rac_textSignal() ~> RAC(statusLabel, "text")
        
        RACObserve(self.statusLabel, "text") ~> RAC(observerLabel, "text")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

