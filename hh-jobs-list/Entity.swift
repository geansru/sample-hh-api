//
//  Entity.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

class Entity {
    // MARK: - Properties
    var data: NSData?
    var closure: ([AnyObject])->()
    var contentType: ContentType = ContentType.Vacancies
    init(closure: ([AnyObject])->()) {
        self.closure = closure
    }
    
    convenience init(closure: ([AnyObject])->(), contentType: ContentType) {
        self.init(closure: closure)
        self.contentType = contentType
    }
}

extension Entity {
    // MARK: Helper
    func refresh() {
        let _ = contentType.getContent(self)
    }
}

extension Entity: ParserDelegate {
    // MARK: ParserDelegate
    func parserDidReceiveError(parser: Parser, error: String) {
        Log.d(error)
    }
    func parserWillStartParse(parser: Parser) {
        Log.i(__FUNCTION__)
    }
    func parserDidFinishParse(parser: Parser, result: [AnyObject]) {
        closure(result)
    }
}

extension Entity:  Parseable {}


extension Entity: ContentDelegate {
    // MARK: - ContentDelegate
    func contentDownloaderDidReceiveError(content: Content, status: NetworkState, error: NSError?) {
        Log.i(status.entityValue)
        if let _ = error { Log.e(error!) }
        
    }
    func contentDownloaderDidReceiveResponse(content: Content, response: NSHTTPURLResponse) {
        let mess: String = "Received status code: \(response.statusCode)"
        Log.i(mess)
    }
    func contentDownloaderWillStart(content: Content, status: NetworkState) {
        Log.i(status.entityValue)
    }
    func contentDownloaderDidFinishWithNotFound(content: Content, status: NetworkState) {
        Log.i(status.entityValue)
    }
    func contentDownloaderDidFinishWithResult(content: Content, status: NetworkState, result: NSData) {
        self.data = result
        let _ = Parser(object: self, delegate: self)
        print(status.entityValue)
    }
}