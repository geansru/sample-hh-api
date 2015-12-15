//
//  CompanyParser.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 14.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import SwiftyJSON

final class CompanyParser: Singletonable {
    // MARK: Singleton
    static var shared: CompanyParser = CompanyParser()
    
    // MARK: Public methods
    func parse(data: JSON) -> Company {
        let employer = data["employer"]
        let companyId = employer["id"].string ?? ""
        if let company = CompanyManager.shared.read(companyId) {
            return company
        }
        let company: Company = Company()
        company.companyName = employer["name"].string!
        if let logo = employer["logo_urls"]["240"].string {
            company.companyLogoURL = logo
        }
        company.companyId = companyId
        Thread.shared.main { DataManager.shared.create(company) }
        return company
    }
}