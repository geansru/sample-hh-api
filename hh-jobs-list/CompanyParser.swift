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
        let company: Company = Company()
        company.companyName = employer["name"].string!
        company.companyLogoURL = employer["logo_urls"]["240"].string!
        company.companyId = employer["id"].string!
        return company
    }
}