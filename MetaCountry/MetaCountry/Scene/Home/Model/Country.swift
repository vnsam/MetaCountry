//
//  Country.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import Foundation
import Firebase

struct Country {
    private(set) var countryCode: String
    private(set) var countryName: String
    private(set) var currencyCode: String

    init?(value: [String: AnyObject]) {
        guard
            let countryCode = value["countryCode"] as? String,
            let countryName = value["countryName"] as? String,
            let currencyCode = value["currencyCode"] as? String else {
                return nil
        }
        self.countryCode = countryCode
        self.countryName = countryName
        self.currencyCode = currencyCode
    }
}
