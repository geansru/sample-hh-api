//
//  VacanciesNetworkManager.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

final class VacanciesNetworkManager: Singletonable {
    
    static var shared: VacanciesNetworkManager = VacanciesNetworkManager()
    
    func getAllContent(delegate: ContentDelegate) -> Content {
        let object: VacanciesDownloader = VacanciesDownloader()
        return Content(object: object, delegate: delegate)
    }
}

private class VacanciesDownloader: Downloadable {
    func getURL() -> NSURL? {
        return NSURL(string: "https://api.hh.ru/vacancies/")
    }
    var dataTask: NSURLSessionDataTask?
}