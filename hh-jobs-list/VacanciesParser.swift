//
//  VacanciesParser.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import SwiftyJSON

final class VacanciesParser: Parserable, Singletonable {
    // MARK: Singleton
    static var shared: VacanciesParser = VacanciesParser()
    
    // MARK: Public methods
    func parseEntity(items: JSON, i: Int)-> Vacancy {
        let vacancy: Vacancy = Vacancy()
        let data = items[i]
        vacancy.vacancyName = data["name"].string!
        vacancy.salary = parseSalary(data["salary"])
        vacancy.company = CompanyParser.shared.parse(data)
        return vacancy
    }
    
    func parse(parser: Parser) -> [Vacancy] {
        var list: [Vacancy] = []
        let data = JSON(data: parser.object.data!)
        let items = data["items"]
        for i in 0..<items.count {
            list.append( parseEntity(items, i: i) )
        }
        Log.i(items.count.description)
        return list
    }

    // MARK: Helpers
    private func parseSalary(data: JSON) -> String {
        var result = ""
        
        if let fromSalary = data["to"].string {
            result = "от \(fromSalary) "
        }
        
        
        if let toSalary = data["to"].string {
            result += "до \(toSalary) "
        }
        
        if let currency = data["currency"].string {
            result += currency
        }
        return result
    }
}