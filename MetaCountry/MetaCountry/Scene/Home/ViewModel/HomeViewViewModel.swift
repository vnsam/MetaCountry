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
	private let lastEntry = "ZW" // using this as end-of-page tag. Normal I'd expect JSON result to send end-of-page information. Didn't do it - since it'll add to our assignment scope.

	// MARK: - Initializer
	init(delegate: HomeViewViewModelDelegate? = nil, countries: [Country] = []) {
		self.delegate = delegate
		appendCountries(countries)
	}

	// viewmodel - delegate
	weak var delegate: HomeViewViewModelDelegate?

    // MARK: - Properties
	private(set) var countries: [Country] = [] {
		didSet {
			sendDelegate()
		}
	}
	private(set) var itemsPerPage: UInt = 0

	// MARK: - Computed Properties
	var lastCountryCode: String? {
		return countries.last?.countryCode
	}

    //db-reference
    private var databaseReference: DatabaseReference {
        return Database.database().reference(withPath: rootKey).child(childKey)
    }

    //build query
    private var query: DatabaseQuery {
        guard nil != lastCountryCode  else {
            return databaseReference.queryOrdered(byChild: countryCode).queryLimited(toFirst: itemsPerPage)
        }
        return databaseReference.queryOrdered(byChild: countryCode).queryStarting(atValue: lastCountryCode!).queryLimited(toFirst: itemsPerPage + 1) // +1 because - `queryStarting(atValue:` - also includes the current element. Gotta check the firbase documentation.
    }

	// MARK: - View Controller Binding Properties
	func numberOfItems() -> Int {
		guard let lastCountryCode = countries.last?.countryCode,
		lastCountryCode == lastEntry else { return countries.count + 1 }
		return countries.count
	}

	var isLastEntry: Bool {
		return countries.last?.countryCode == lastEntry
	}

	// MARK: - Data Read/Write
	private func appendCountries(_ countries: [Country]) {
		self.countries.append(contentsOf: countries)
	}

	func populateCountries(itemsPerPage: UInt) {
		self.itemsPerPage = itemsPerPage

		var countries: [Country] = [] // keeping this local copy, so that `delegate` - would be sent only once for sequence update. 

        query.observeSingleEvent(of: .value) {[weak self] (snapshot) in
            for child in snapshot.children {
                if let data = child as? DataSnapshot,
                    let value = data.dictionaryFromValue,
                    let country = Country.init(value: value) {
                    if country.countryCode != self?.lastCountryCode {
                        countries.append(country)
                    }
                }
            }

			self?.appendCountries(countries)
        }
    }

	// MARK: - View Controller Binding Functions
	private func sendDelegate() {
		delegate?.didUpdateCountries()
	}

	func countryAtIndex(_ index: Int) -> Country? {
		guard countries.count > 0 else {
			return nil
		}
		return countries[index]
	}
}
