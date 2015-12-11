//
//  NetworkProtocols.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

protocol ContentDelegate {
    func contentDownloaderDidReceiveError(content: Content, status: NetworkState, error: NSError?)
    func contentDownloaderDidReceiveResponse(content: Content, response: NSHTTPURLResponse)
    func contentDownloaderWillStart(content: Content, status: NetworkState)
    func contentDownloaderDidFinishWithNotFound(content: Content, status: NetworkState)
    func contentDownloaderDidFinishWithResult(content: Content, status: NetworkState, result: NSData)
}

protocol Downloadable {
    func getURL() -> NSURL?
    var dataTask: NSURLSessionDataTask? {get set}
}