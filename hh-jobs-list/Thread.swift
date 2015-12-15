//
//  Thread.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 15.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

final class Thread: Singletonable {
    // Static properties
    static let bgQueueName = "ru.geans.ios.Parser.bgqueue"
    let backgroundQueue = dispatch_queue_create(Thread.bgQueueName, nil)
    let mainQueue = dispatch_get_main_queue()
    
    // MARK: Singleton
    static var shared: Thread = Thread()
    
    func main(closure: ()->()) {
        dispatch_async( mainQueue ) {
            closure()
        }
    }
    
    func background(closure: ()->()) {
        dispatch_async( backgroundQueue ) {
            closure()
        }
    }
}