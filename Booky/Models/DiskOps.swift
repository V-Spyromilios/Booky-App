//
//  DiskOps.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 20.09.22.
//

import Foundation

extension FileManager {
	static var documentDirectoryURL: URL {
		`default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
	}
}

