//
//  HomeViewViewModelTests.swift
//  MetaCountryTests
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import XCTest

@testable import MetaCountry

class MockHomeViewViewModelDelegate: HomeViewViewModelDelegate {
	var delegateCalled = false

	func didUpdateCountries() {
		delegateCalled = true
	}
}

class HomeViewViewModelTests: XCTestCase {

	var sut: HomeViewViewModel!
	var mockHomeViewViewModelDelegate: MockHomeViewViewModelDelegate!

    override func setUp() {
		let countries = [
			Country.init(code: "IN", name: "India", currencyCode: "INR"),
			Country.init(code: "US", name: "United States", currencyCode: "USD")
		]

		mockHomeViewViewModelDelegate = MockHomeViewViewModelDelegate()

		sut = HomeViewViewModel(delegate: mockHomeViewViewModelDelegate,
								countries: countries)
    }

    override func tearDown() {
        sut = nil
		super.tearDown()
    }

	func testLastCountryCode_ShouldReturn_LastCountryCode() {
		XCTAssertEqual("US", sut.lastCountryCode!)
	}

	func testIsLastEntry_WhenLastCountryCode_ZW_ShouldReturnTrue() {
		let countries = [
			Country.init(code: "IN", name: "India", currencyCode: "INR"),
			Country.init(code: "US", name: "United States", currencyCode: "USD"),
			Country(code: "ZW", name: "Zimbabwe", currencyCode: "ZWD")
		]
		let sut = HomeViewViewModel(countries: countries)
		XCTAssertTrue(sut.isLastEntry)
	}

	func testNumberOfRows_WhenLastEntryIsNotReached_ShouldReturn_Countries_Count_Plus_Loading_Cell() {
		let countries = [
			Country.init(code: "IN", name: "India", currencyCode: "INR"),
			Country.init(code: "US", name: "United States", currencyCode: "USD")
		]

		let sut = HomeViewViewModel(countries: countries)

		XCTAssertEqual(3, sut.numberOfItems())
	}

	func testNumberOfRows_WhenLastEntryIsReached_ShouldReturn_Countries_Count() {
		let countries = [
			Country.init(code: "IN", name: "India", currencyCode: "INR"),
			Country.init(code: "US", name: "United States", currencyCode: "USD"),
			Country(code: "ZW", name: "Zimbabwe", currencyCode: "ZWD")
		]

		let sut = HomeViewViewModel(countries: countries)

		XCTAssertEqual(3, sut.numberOfItems())
	}

	func testCountryAtIndex_WhenGivenExisitinIndex_Returns_Country() {
		let country = sut.countryAtIndex(0)!
		/*
		Could've used `Equatable` on Country object. Don't wanna conform to `Equatble` only for Unit Testing. Hence multiple insertions.
		*/
		XCTAssertEqual("IN", country.countryCode)
		XCTAssertEqual("India", country.countryName)
		XCTAssertEqual("INR", country.currencyCode)
	}

	func testDelegateCallBack_WhenCountries_Appended() {
		XCTAssertTrue(mockHomeViewViewModelDelegate.delegateCalled)
	}
}
