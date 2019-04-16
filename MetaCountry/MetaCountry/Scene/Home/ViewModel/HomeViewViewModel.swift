//
//  HomeViewViewModel.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import Foundation
import FirebaseDatabase

class HomeViewViewModel {
    // MARK: - Constants
    private let rootKey = "countries"
    private let childKey = "country"
    private let countryCode = "countryCode"

    // MARK: - Properties
    private(set) var countries: [Country] = []

    //db-reference
    private var databaseReference: DatabaseReference {
        return Database.database().reference(withPath: rootKey).child(childKey)
    }

    //build query
    private var query: DatabaseQuery {
        guard nil != lastCountryCode  else {
            return databaseReference.queryOrdered(byChild: countryCode).queryLimited(toFirst: 5)
        }
        return databaseReference.queryOrdered(byChild: countryCode).queryStarting(atValue: lastCountryCode!).queryLimited(toFirst: 6)
    }

    var lastCountryCode: String? {
        return countries.last?.countryCode
    }

    func fetchCountries() {
        query.observeSingleEvent(of: .value) {[weak self] (snapshot) in
            for child in snapshot.children {
                if let data = child as? DataSnapshot,
                    let value = self?.dictionaryFromSnapshot(data),
                    let country = Country.init(value: value) {
                    if country.countryCode != self?.lastCountryCode {
                        self?.countries.append(country)
                    }
                }
            }
        }
    }

    private func dictionaryFromSnapshot(_ snapshot: DataSnapshot) -> [String: AnyObject] {
        guard let value = snapshot.value as? [String: AnyObject] else { return [:] }
        return value
    }
}
