//
//  Company.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import RealmSwift

class Company: Object {
    dynamic var companyName = ""
    dynamic var companyLogoURL = ""
    dynamic var companyId = ""
    let vacancies = List<Vacancy>()
}