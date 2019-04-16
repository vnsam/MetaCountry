//
//  DataSnapshot+Extension.swift
//  MetaCountry
//
//  Created by Vignesh Narayanasamy on 16/04/19.
//  Copyright © 2019 Vignesh Narayanasamy. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DataSnapshot {
	var dictionaryFromValue: [String: AnyObject]? {
		guard let valueDictionary = self.value as? [String: AnyObject] else { return nil }
		return valueDictionary
	}
}
