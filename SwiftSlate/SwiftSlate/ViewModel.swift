//
//  ViewModel.swift
//  
//
//  Created by Kyle Oba on 8/6/14.
//
//

import Foundation

class ViewModel: NSObject {
    
    let equation: RACSignal!
    let equationSubject: RACReplaySubject!
    let randomNumberCommand: RACCommand!
    
    dynamic var randomNum: UInt32 = 0
    
    override init() {
        super.init()
        // Use a subject, as an example:
        equationSubject = RACReplaySubject(capacity: 1)
        equation = RACSignal.createSignal {
            (subscriber: RACSubscriber!) -> RACDisposable! in
            self.equationSubject.subscribe(subscriber)
            return RACDisposable()
        }
        
        self.randomNumberCommand = RACCommand(enabled: nil, signalBlock: {
            (input: AnyObject!) -> RACSignal! in
            return RACSignal.createSignal({ (subscriber: RACSubscriber!) -> RACDisposable! in
                let num: UInt32 = arc4random() % 10
                let r: String = "\(num) + \(num)"
                self.randomNum = num * 2
                
                self.equationSubject.sendNext(r)
                subscriber.sendNext(r)
                subscriber.sendCompleted()
                
                return RACDisposable()
            })
        })
    }
}
