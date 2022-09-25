//
//  DiskOps.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 20.09.22.
//

import Foundation

extension FileManager {
	static var documentsDirectoryURL: URL {
		`default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
	}
}

