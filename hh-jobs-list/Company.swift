//
//  Company.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import RealmSwift

class Company: Object {
    dynamic var companyName = ""
    dynamic var companyLogoURL = ""
    dynamic var companyId = ""
    let vacancies = List<Vacancy>()
    var imageId: String? { return companyLogoURL.componentsSeparatedByString("/").last }
    var logoURL: NSURL? {
        return NSURL(string: companyLogoURL)
    }
    var localFilePath: String? {
        if let imageId = imageId {
            let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let path = paths[0] + "/" + imageId
            return path
        }
        return nil
    }
    var localFileURL: NSURL? {
        if let path = localFilePath {
            return NSURL(fileURLWithPath: path)
        }
        return nil
    }
    var isImageDownloaded: Bool {
        guard let url = localFileURL else { return false }
        guard let path = url.path else { return false }
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
    var logo: UIImage? {
        if isImageDownloaded {
            return UIImage(contentsOfFile: localFilePath!)
        }
        return nil
    }
    var logoHeight: CGFloat {
        return logo?.size.height ?? 120
    }
}