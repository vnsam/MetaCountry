//
//  LoadingCell.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {
	// MARK: - Constants
	static let identifier = "LoadingCell"

	// MARK: - Outlets
	@IBOutlet weak var acitivtyIndicator: UIActivityIndicatorView!

	func showLoadingIndicator() {
		acitivtyIndicator.startAnimating()
	}

	func hideLoadingIndicator() {
		acitivtyIndicator.stopAnimating()
	}
}
