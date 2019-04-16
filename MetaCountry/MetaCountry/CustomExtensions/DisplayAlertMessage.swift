//
//  DisplayAlertMessage.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayAlertMessage {

}

extension DisplayAlertMessage where Self: UIViewController {
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alert.addAction(okayAction)
		self.present(alert, animated: true, completion: nil)
	}
}
