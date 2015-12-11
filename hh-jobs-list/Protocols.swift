//
//  Protocols.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

protocol Singletonable {
    static var shared: Self { get }
}

protocol DataSourcesable {
    typealias T
    var records: [T] { get }
}

protocol Crudable {
    typealias T
    func create(model: T)
    func update(model: T)
    func delete(model: T)
}

protocol Dropable {
    func drop()
}