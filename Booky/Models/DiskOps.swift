//
//  DiskOps.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 20.09.22.
//

import Foundation

func loadJSON() {
	guard let loadBookURL = Bundle.main.url(forResource: "loadBook", withExtension: "json")
	else {
		print("FUCKED UP")
		return }

	let decoder = JSONDecoder()
	do {
		let loadBookData = try Data(contentsOf: loadBookURL)
		let loadBook = try decoder.decode(Library.self, from: loadBookData)
		} catch let error { print(error.localizedDescription) }
}
