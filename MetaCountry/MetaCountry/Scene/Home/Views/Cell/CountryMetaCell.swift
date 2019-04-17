//
//  CountryMetaCell.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import UIKit

class CountryMetaCell: UICollectionViewCell {
	// MARK: - Constants
	static let identifier = "CountryMetaCell"

	// MARK: - Outlets
	@IBOutlet weak var countryCodeLabel: UILabel!
	@IBOutlet weak var countryNameLabel: UILabel!

	func setText(countryCode: String?, countryName: String?) {
		countryCodeLabel.text = countryCode
		countryNameLabel.text = countryName
	}
}
