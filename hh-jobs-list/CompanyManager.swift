//
//  CompanyManager.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

final class CompanyManager: Singletonable, DataSourcesable {
    
    // Singletonable
    static var shared: CompanyManager = CompanyManager()
    
    // Recordsable
    var records: [Company] {
        return DataManager.shared.read(Company).toArray() as! [Company]
    }
}

extension CompanyManager: Crudable {
    func create(model: Company) {
        DataManager.shared.create(model)
    }
    func update(model: Company) {
        DataManager.shared.update(model)
    }
    func delete(model: Company) {
        DataManager.shared.delete(model)
    }
    func drop() {
        DataManager.shared.drop(Company)
    }
}