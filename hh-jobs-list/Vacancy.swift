//
//  Vacancy.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import RealmSwift

class Vacancy: Object {
    dynamic var salary = ""
    dynamic var vacancyName = ""
    dynamic var company: Company?
    dynamic var vacancyId = ""
    dynamic var publishedAt = NSDate()
}