//
//  ViewController.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewViewModelDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, DisplayAlertMessage {
	// MARK: - Constants
	private let itemWidth = 125.0
	private let itemheight = 75.0

    // MARK: - Outlets
	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			collectionView.dataSource = self
			collectionView.delegate = self
		}
	}

	// MARK: - Properties
    private var viewModel = HomeViewViewModel()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

		registerViewModelDelegate()

		collectionView.invert()

		setupUI()
    }

	// datasource
	private func fetchCountries() {
		viewModel.populateCountries(itemsPerPage: itemsPerPage)
	}
	// ui driven calc
	private var itemsPerPage: UInt {
		let collectionViewHeight = collectionView.frame.height
		let collectionViewWidth = collectionView.frame.width
		let itemsDisplayedPerRow = collectionViewWidth / CGFloat(itemWidth)
		return UInt((collectionViewHeight / CGFloat(itemheight) * itemsDisplayedPerRow))
	}

	private func shouldShowLoading(indexPath: IndexPath) -> Bool {
		return isLastIndexPath(indexPath: indexPath) && !viewModel.isLastEntry
	}

	private func registerViewModelDelegate() {
		viewModel.delegate = self
	}

	// MARK: - HomeViewViewModelDelegate
	func didUpdateCountries() {
		collectionView.reloadData()
	}

	// MARK: - UI Update
	private func setupUI() {
		let countryMetaCellNib = UINib(nibName: "CountryMetaCell", bundle: nil)
		collectionView.register(countryMetaCellNib, forCellWithReuseIdentifier: CountryMetaCell.identifier)

		let loadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
		collectionView.register(loadingCellNib, forCellWithReuseIdentifier: LoadingCell.identifier)

		collectionView.invert()
	}

	// MARK: - UICollectionViewDataSource
	private func isLastIndexPath(indexPath: IndexPath) -> Bool {
		return indexPath.row == collectionView.numberOfItems(inSection: 0) - 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItems()
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if shouldShowLoading(indexPath: indexPath) {
			return loadingCell(collectionView: collectionView, indexPath: indexPath)
		} else {
			return countryMetaCellForIndexPath(collectionView: collectionView, indexPath: indexPath)
		}
	}

	private func countryMetaCellForIndexPath(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryMetaCell.identifier, for: indexPath) as? CountryMetaCell else {
			return UICollectionViewCell()
		}

		cell.invert()

		let country = viewModel.countryAtIndex(indexPath.row)

		cell.setText(countryCode: country?.countryCode, countryName: country?.countryName, currencyCode: country?.currencyCode)

		return cell
	}

	private func loadingCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.identifier, for: indexPath) as? LoadingCell else { return UICollectionViewCell() }
		cell.showLoadingIndicator()
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if shouldShowLoading(indexPath: indexPath) {
			fetchCountries()
		}
	}

	// MARK: - UICollectionViewDelegateFlowLayout
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: itemWidth, height: itemheight)
	}

	// MARK: - UICollectionViewDelegate
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let country = viewModel.countryAtIndex(indexPath.row) {
			let title = "Monetary Unit"
			let message = "The currency code for \(country.countryName) is - \(country.currencyCode)"
			alertCurrencyCode(title: title, message: message)
		}
	}
}
