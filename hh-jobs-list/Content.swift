//
//  Content.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

class Content {
    var delegate: ContentDelegate?
    var object: Downloadable
    private var status: NetworkState
    init(object: Downloadable) {
        self.object = object
        status = NetworkState.NotInitialized
    }
    
    convenience init(object: Downloadable, delegate: ContentDelegate) {
        self.init(object: object)
        self.delegate = delegate
        
        download()
    }
    
    func download() {
        status = .Searching
        dispatch_async(dispatch_get_main_queue()) {
            self.delegate?.contentDownloaderWillStart(self, status: self.status)
        }
        if let url = object.getURL() {
            let session = NSURLSession.sharedSession()
            object.dataTask = session.dataTaskWithURL(url, completionHandler: {
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if let error = error {
                    self.status = .Error(errorMessage: response?.description ?? "")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.contentDownloaderDidReceiveError(self, status: self.status, error: error)
                    }
                }
                
                if let response = response as? NSHTTPURLResponse {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.contentDownloaderDidReceiveResponse(self, response: response)
                    }
                    if response.statusCode != 200 {
                        let message = "response code is \(response.statusCode)"
                        self.status = .Error(errorMessage: message)
                        dispatch_async(dispatch_get_main_queue()) {
                            self.delegate?.contentDownloaderDidReceiveError(self, status: self.status, error: nil)
                        }
                    }
                }
                
                if let data = data {
                    self.status = .Result(result: [data])
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.contentDownloaderDidFinishWithResult(
                            self, status: self.status, result: data)
                    }
                } else {
                    self.status = .NotFound
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.contentDownloaderDidFinishWithNotFound(self, status: self.status)
                    }
                }
            })
            object.dataTask?.resume()
        } else {
            let message = "class: Content; function \(__FUNCTION__); object.getURL() return nil"
            status = NetworkState.Error(errorMessage: message)
            dispatch_async(dispatch_get_main_queue()) {
                self.delegate?.contentDownloaderDidReceiveError(self, status: self.status, error: nil)
            }
        }
    }
}