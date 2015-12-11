//
//  VacanciesParser.swift
//  hh-jobs-list
//
//  Created by Дмитрий on 11.12.15.
//  Copyright © 2015 geans.ru. All rights reserved.
//

import Foundation
import SwiftyJSON

class VacanciesParser: Parserable {
    // MARK: Helpers
    class func parseEntity(items: JSON, i: Int)-> Vacancy {
        let vacancy: Vacancy = Vacancy()
        let data = items[i]
//        city.city_name = data["city_name"].string!
//        
//        city.city_latitude = data["city_latitude"].double!
//        city.city_longitude = data["city_longitude"].double!
//        city.android_driver_apk_link = data["android_driver_apk_link"].string!
//        city.city_api_url = data["city_api_url"].string!
//        city.city_doc_url = data["city_doc_url"].string!
//        city.city_domain = data["city_domain"].string!
//        city.city_id = data["city_id"].int!
//        city.city_mobile_server = data["city_mobile_server"].string!
//        city.parent_city = Int(data["parent_city"].doubleValue)
//        city.city_spn_latitude = data["city_spn_latitude"].double!
//        city.city_spn_longitude = data["city_spn_longitude"].double!
        return vacancy
    }
    
    class func parse(parser: Parser) -> [Vacancy] {
        var list: [Vacancy] = []
        let data = JSON(data: parser.object.data!)
        let items = data["cities"]
        for i in 0..<items.count {
            list.append( VacanciesParser.parseEntity(items, i: i) )
        }
        return list
    }

}