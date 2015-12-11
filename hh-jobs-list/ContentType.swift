//
//  ContentType.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation

enum ContentType {
    case Vacancies

    func getContent(delegate: ContentDelegate) -> Content {
        switch self {
        case .Vacancies: return VacanciesNetworkManager.shared.getAllContent(delegate)
        }
    }
}