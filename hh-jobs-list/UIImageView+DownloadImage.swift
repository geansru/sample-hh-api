//
//  UIImageView+DownloadImage.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 14.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageWithURL(url: NSURL) -> NSURLSessionDownloadTask {
        let session = NSURLSession.sharedSession()
        
        let downloadTask = session.downloadTaskWithURL(url, completionHandler: {
            [weak self] tmpURL, response, error in
            
            if error == nil && tmpURL != nil {
                if let data = NSData(contentsOfURL: tmpURL!) {
                    if let image = UIImage(data: data) {
                        Thread.shared.main {
                            if let strongSelf = self { strongSelf.image = image }
                        }
                    }
                }
            }
            })
        
        downloadTask.resume()
        return downloadTask
    }
    
    func loadLogo(forCompany company: Company) {
        if let logo = company.logo {
            Thread.shared.main { [weak self] in self?.image = logo }
            return
        }
        loadCompanyLogo(company)
    }
    
    private func loadCompanyLogo(company: Company) -> NSURLSessionDownloadTask? {
        
        let isImageDownloaded = company.isImageDownloaded
        
        if isImageDownloaded {
            self.image = company.logo
            return nil
        }
        let session = NSURLSession.sharedSession()
        let localFileURL = company.localFileURL!

        let downloadTask = session.downloadTaskWithURL(company.logoURL!, completionHandler: {
            [weak self] tmpURL, response, error in
            
            if error == nil && tmpURL != nil {
                if let data = NSData(contentsOfURL: tmpURL!) {
                    do {
                        try NSFileManager.defaultManager().moveItemAtURL(tmpURL!, toURL: localFileURL)
                    } catch let e as NSError { Log.e(e) }
                    if let image = UIImage(data: data) {
                        Thread.shared.main {
                            if let strongSelf = self { strongSelf.image = image }
                        }
                    }
                }
            }
            })
        
        downloadTask.resume()
        return downloadTask
    }
}

