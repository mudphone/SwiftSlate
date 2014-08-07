//
//  ViewModel.swift
//  
//
//  Created by Kyle Oba on 8/6/14.
//
//

import Foundation

class ViewModel {
    
    let randomNumber: RACSignal!
    let randomSubject: RACReplaySubject!
    let randomNumberCommand: RACCommand!
    
    init() {
        // Use a subject, because I can't get RACObserve to work on a Swift object or NSObject:
        randomSubject = RACReplaySubject(capacity: 1)
        randomNumber = RACSignal.createSignal({ (subscriber: RACSubscriber!) -> RACDisposable! in
            self.randomSubject.subscribe(subscriber)
            return RACDisposable()
        })
        
        self.randomNumberCommand = RACCommand(enabled: nil, signalBlock: { (input: AnyObject!) -> RACSignal! in
            return RACSignal.createSignal({ (subscriber: RACSubscriber!) -> RACDisposable! in
                let r: String = "\(arc4random())"
                self.randomSubject.sendNext(r)
                subscriber.sendNext(r)
                subscriber.sendCompleted()
                
                return RACDisposable()
            })
        })
    }
}
