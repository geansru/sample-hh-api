//
//  VacancyManager.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

final class VacancyManager: Singletonable, DataSourcesable {
    
    // Singletonable
    static var shared: VacancyManager = VacancyManager()
    
    // Recordsable
    var records: [Vacancy] {
       return DataManager.shared.read(Vacancy).sorted("publishedAt").toArray() as! [Vacancy]
    }
}

extension VacancyManager: Crudable {
    func read(id: String) -> Vacancy? {
        let results = DataManager.shared.read(Vacancy).filter("vacancyId = \(id)")
        return results.first as? Vacancy
    }
    
    func create(model: Vacancy) {
        DataManager.shared.create(model)
    }
    func update(model: Vacancy) {
        DataManager.shared.update(model)
    }
    func delete(model: Vacancy) {
        DataManager.shared.delete(model)
    }
    func drop() {
        DataManager.shared.drop(Vacancy)
    }
}