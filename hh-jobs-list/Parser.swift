//
//  Parser.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

class Parser {
    var delegate: ParserDelegate?
    var object: Parseable
    
    init(object: Parseable) {
        self.object = object
    }
    
    convenience init(object: Parseable, delegate: ParserDelegate) {
        self.init(object: object)
        self.delegate = delegate
        parse()
    }
    
    // MARK: Synchronous/Asynchronous parse function
    func parse() {
        parse(true)
    }
    
    func parse(isSync: Bool) {
        if isSync {
            parseSync()
        } else {
            parseAsyncWrapper()
        }
    }
    
    // MARK: Main parse functions
    private func parseSync() {
        self.delegate?.parserWillStartParse(self)
        var result: [AnyObject]
        switch self.object.contentType {
        case .Vacancies:
            result = VacanciesParser.shared.parse(self)
        }
        self.delegate?.parserDidFinishParse(self, result: result)
    }
    
    private func parseAsyncWrapper() {
        Thread.shared.background { self.parseAsync() }
    }
    
    private func parseAsync() {
        Thread.shared.main {
            self.delegate?.parserWillStartParse(self)
        }
        var result: [AnyObject]
        switch self.object.contentType {
        case .Vacancies:
            result = VacanciesParser.shared.parse(self)
        }
        
        Thread.shared.main {
            self.delegate?.parserDidFinishParse(self, result: result)
        }
    }
}