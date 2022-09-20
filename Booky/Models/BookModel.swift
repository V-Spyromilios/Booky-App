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

// To conform to Codable:  Decodable
required init(from decoder: Decoder) throws {
	let values = try decoder.container(keyedBy: CodingKeys.self)
	title = try values.decode(String.self, forKey: .title)
	author = try values.decode(String.self, forKey: .author)
	review = try values.decode(String.self, forKey: .review)
	readMe = try values.decode(Bool.self, forKey: .readMe)
	date = try values.decode(Date.self, forKey: .date)
}

// To conform to Codable:  Encodable
func encode(to encoder: Encoder) throws {
	var container = encoder.container(keyedBy: CodingKeys.self)
	try container.encode(title, forKey: .title)
	try container.encode(author, forKey: .author)
	try container.encode(review, forKey: .review)
	try container.encode(readMe, forKey: .readMe)
	try container.encode(date, forKey: .date)
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

// To conform with Hashable: (Identifiable simply with id here which is prepackaged:
extension Book: Hashable, Identifiable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		//hasher.combine(ObjectIdentifier(self))
	}
}

// To conform to Codable:
extension Book: Codable {
	enum CodingKeys: String, CodingKey {
		case title
		case author
		case review
		case readMe
		case date
	}
}
