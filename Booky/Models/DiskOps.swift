//
//  DiskOps.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 20.09.22.
//

import Foundation

func loadJSON()-> [Book]? {
	guard let loadBookURL = Bundle.main.url(forResource: "loadBook", withExtension: "json")
	else {
		print("FUCKED UP")
		return nil
	}

	let decoder = JSONDecoder()
	do {
		let loadBookData = try Data(contentsOf: loadBookURL)
		let loadBook = try decoder.decode(Library.self, from: loadBookData)
		print(loadBook.booksCache[0].author)
		return loadBook.booksCache
		} catch let error { print(error.localizedDescription) }
	return nil }
