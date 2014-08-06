//
//  PDCRACExtensions.swift
//  SwiftSlate
//
//  Created by Kyle Oba on 8/5/14.
//  Copyright (c) 2014 Pas de Chocolat. All rights reserved.
//
/// Extensions for RAC based on:
/// http://www.scottlogic.com/blog/2014/07/24/mvvm-reactivecocoa-swift.html

import Foundation

struct RAC  {
    var target : NSObject!
    var keyPath : String!
    var nilValue : AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

infix operator ~> {}
func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}

func RACObserve(target: NSObject!, keyPath: String) -> RACSignal  {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}