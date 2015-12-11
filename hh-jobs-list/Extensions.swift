//
//  Extensions.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Results.Element] {
        return map { $0 }
    }
}

extension List {
    func toArray() -> [List.Element] {
        return map { $0 }
    }
}

extension String {
    var length: Int { return characters.count }
}