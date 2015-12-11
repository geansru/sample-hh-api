//
//  NetworkState.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

enum NetworkState {
    case NotInitialized
    case Error(errorMessage: String)
    case Searching
    case NotFound
    case Result(result: [AnyObject])
    
    var entityValue: String {
        switch self {
        case .NotInitialized: return "Not Initialized"
        case .Error(let errorMessage): return errorMessage
        case .Searching: return "Searching"
        case NotFound: return "Not Found"
        case Result(let list): return "Result: recieved \(list.count) object(s)."
        }
    }
}