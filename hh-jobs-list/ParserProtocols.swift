//
//  ParserProtocols.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ParserDelegate {
    func parserDidReceiveError(parser: Parser, error: String)
    func parserWillStartParse(parser: Parser)
    func parserDidFinishParse(parser: Parser, result: [AnyObject])
}

protocol Parseable {
    var data: NSData? { get set }
    var contentType: ContentType { get set }
}


protocol Parserable {
    typealias T
    static func parseEntity(items: JSON, i: Int) -> T
    static func parse(parser: Parser) -> [T]
}