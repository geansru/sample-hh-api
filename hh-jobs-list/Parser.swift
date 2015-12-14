//
//  Parser.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

class Parser {
    private let queueName = "ru.geans.ios.Parser.bgqueue"
    let backgroundQueue: dispatch_queue_t!
    var delegate: ParserDelegate?
    var object: Parseable
    
    init(object: Parseable) {
        self.object = object
        backgroundQueue = dispatch_queue_create(queueName, nil)
    }
    
    convenience init(object: Parseable, delegate: ParserDelegate) {
        self.init(object: object)
        self.delegate = delegate
        parse()
    }
    
    // MARK: Main parse function
    func parse() {
        dispatch_async(backgroundQueue) {
            self.parseAsync()
        }
    }
    
    // MARK: Parse func body
    private func parseAsync() {
        dispatch_async(dispatch_get_main_queue()) {
            self.delegate?.parserWillStartParse(self)
        }
        var result: [AnyObject]
        switch object.contentType {
        case .Vacancies: result = VacanciesParser.parse(self)
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.delegate?.parserDidFinishParse(self, result: result)
        }
    }
}