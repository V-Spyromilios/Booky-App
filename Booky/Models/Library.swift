//
//  Library.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import Foundation
import SwiftUI

enum Section: CaseIterable, Codable {
	case unread
	case finished
}


class Library: ObservableObject {
	var sortedBooks: [Section: [Book]] {
		get {
		let groupedBooks = Dictionary(grouping: booksCache, by: \.readMe)
		return Dictionary(uniqueKeysWithValues: groupedBooks.map {
			(($0.key ? .unread : .finished), $0.value)
		})
		}
		set { //TODO: Check this
			booksCache = newValue
				.sorted{ $1.key == .finished }
				.flatMap({ $0.value })
		}
}

	/// Adds a new book at the start of the booksCache
	func addNewBook(book: Book, image: Image?) {
		booksCache.insert(book, at: 0)
		images[book] = image
		sortBooks()
	}

/// Deletes book directly from 'booksCache' and its image from 'images' Dictionary
	func deleteBook(book: Book) {
		if let index = booksCache.firstIndex(of: book) {
			if images[book] != nil {
				images[book] = nil
			}
			booksCache.remove(at: index)
			sortBooks()
		} else { return }
	}
	
// /// Alternative func to deleteBook :
//	func delBook(atoffSets offsets: IndexSet, section: Section) {
//		let booksBeforeDeletion = booksCache
//
//		sortedBooks[section]?.remove(atOffsets: offsets)
//
//		for change in booksCache.difference(from: booksBeforeDeletion) {
//			if case .remove(_, let deletedBook, _) = change {
//				images[deletedBook] = nil
//			}
//		}
//	}

//TODO: Add description
	func sortBooks() {
		booksCache = sortedBooks
			.sorted{ $1.key == .finished }
			.flatMap({ $0.value })
			.sorted(by: <)
		objectWillChange.send()
	}

///move book from oldOffSets: IndexSet to newOffset: Int, withing the given section: Section
	func moveBook(oldOffSets: IndexSet, newOffset: Int, section: Section) {
		sortedBooks[section]?.move(fromOffsets: oldOffSets, toOffset: newOffset)
	}


	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		booksCache = try values.decode([Book].self, forKey: .booksCache)
		//images = try values.decode(images.self, forKey: .images)
	}


	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(booksCache, forKey: .booksCache)
		//try container.encode(images, forKey: .images)
	}
	
public	init() {
		loadJSON()
	}

///in-memory cache of the manualy shorted books
@Published var booksCache: [Book] = [
//	.init(title: "Working with SwiftUI", author: "Prince of BellAir", date: Date()),
//	.init(title: "Zero to One", author: "Peter Thiel", date: Date()),
//	.init(title: "LiftOff", author: "Eric Berger", date: Date()),
//	.init(title: "Space and Gravity", author: 	"Emma Clemens", date: Date()),
//	.init(title: "Develop in Swift", author: "Apple", date: Date()),
//	.init(title: "the Secret of Our Success", author: "Joseph Hendrich", date: Date()),
//	.init(title: "Καραμανλής", author: "Σωτήρης Ριζάς", date: Date()),
//	.init(title: "The Mision", author: "David W. Brown", date: Date()),
//	.init(title: "Ο Πελλοπονησιακός Πόλεμος", author: "Donald Kagan", date: Date()),
//	.init(title: "Astrophysics in a Nutshell", author: "Dan Maoz", date: Date()),
//	.init(title: "Η Ελλάδα, οι Ηνωμένες Πολιτείες και η Ευρώπη 1961-1964", author: "Σωτήρης Ριζάς", date: Date()),
//	.init(title: "Ελλάδα 1453-1821", author: "David Brewer", date: Date()),
//	.init(title: "Ενα σκοτεινό δωμάτιο, 1967-1974", author: "Παπαχελάς Αλέξης", date: Date()),
//	.init(title: "1821 - Από την επανάσταση στο κράτος", author: "Κωνσταντίνα Μπότσιου", date: Date()),
//	.init(title: "Η Αθήνα τον 19ο αιώνα", author: "Θανάσης Γιοχάλας", date: Date()),
//	.init(title: "Aναζητώντας το αόρατο Σύμπαν", author: "David Elbaz", date: Date()),
	
]

@Published var images: [Book: Image] = [:]
}

extension Library: Codable {
	enum CodingKeys: String, CodingKey {

		case booksCache
		//case images
	}
}
