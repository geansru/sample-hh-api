//
//  NetworkManager.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

final class NetworkManager: Singletonable {
    
    static var shared: NetworkManager = NetworkManager()
    
    func getContent(object: Downloadable, delegate: ContentDelegate) -> Content {
        return Content(object: object, delegate: delegate)
    }
}