//
//  BookModel.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//


import SwiftUI
import Combine

class Book: ObservableObject
{
	@Published var title: String
	@Published var author: String
	@Published var review: String
	@Published var readMe: Bool
	@Published var date: Date

	init(title: String = "Title",
		 author: String = "Author",
		 review: String = "",
		 readMe: Bool = true,
		 date: Date = Date(timeIntervalSinceReferenceDate: 1))
	{
		self.author = author
		self.title = title
		self.review = review
		self.readMe = readMe
		self.date = date
	}
}

//To conform with Comparable:
extension Book: Comparable {
	static func < (lhs: Book, rhs: Book) -> Bool {
		lhs.date < rhs.date
	}
}

// To conform with Equatable:
extension Book: Equatable {
	static func == (lhs: Book, rhs: Book) -> Bool {
		return lhs === rhs
	}
}

//To conform with Hashable: (Identifiable simply with id here which is prepackaged:
extension Book: Hashable, Identifiable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		//hasher.combine(ObjectIdentifier(self))
	}
}
