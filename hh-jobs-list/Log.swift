//
//  Log.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation


class Log {
    static let LOG_LEVEL = Log.Level.Debug
    
    enum Level: Int { case All=0,Info,Debug,Error,None=999 }
    
    enum DebugLevels {
        case All
        case Info(i: String)
        case Debug(d: String)
        case Error(e: NSError)
        case None
        
        var entityValue: String {
            switch self {
            case .All: return "All"
            case .Info(let i): return "Info: \(i)"
            case .Debug(let d): return "Debug: \(d)"
            case .Error(let e):
                return "Error with code \(e.code): \(e.localizedDescription)"
            default: return ""
            }
        }
        
        var intValue: Int {
            switch self {
            case .All: return Level.All.hashValue
            case .Info: return Level.Info.hashValue
            case .Debug: return Level.Debug.hashValue
            case .Error: return Level.Error.hashValue
            case .None: return Level.None.hashValue
            }
        }
        
        func report() {
            if self.intValue < Log.LOG_LEVEL.hashValue { return }
            switch self {
            case .None, .All: break
            default: Log.log(self.entityValue)
            }
        }
    }
    
    class func i(i: String) {
        Log.log(Log.DebugLevels.Info(i: i))
    }
    
    class func d(d: String) {
        Log.log(Log.DebugLevels.Debug(d: d))
    }

    class func e(error: NSError) {
        Log.log(Log.DebugLevels.Error(e: error))
    }
    
    class func log(level: DebugLevels ) {
        level.report()
    }
    
    class func log(text: String) {
        print(text)
    }
}