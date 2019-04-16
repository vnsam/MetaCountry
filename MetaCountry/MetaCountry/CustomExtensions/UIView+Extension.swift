//
//  UIView+Extension.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func invert() {
		self.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
	}
}
