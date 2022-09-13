//
//  BookViews.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import SwiftUI

extension Book {
	struct ImageView: View {
	let title: String
	var size: CGFloat?
	@Binding var image: SwiftUI.Image?
	let cornerRadius: CGFloat

	var body: some View {
		if let image = image {
			image.resizable()
				.scaledToFit()
				.frame(width: size, height: size)
				.cornerRadius(cornerRadius)
		} else {
			let symbol = Image(title: title) ?? Image(systemName: "text.book.closed") //or .init(systemName...) as the two types of ?? must match
			symbol
				.resizable()
				.frame(width: size, height: size)
				.scaledToFit()
				.font(Font.title.weight(.light))
				.foregroundColor(.secondary.opacity(0.8))
			}
		}
	}
}

extension Image {
	init?(title: String) {
		guard let character = title.first,
		case let symbolName = "\(character.lowercased()).square",
		UIImage(systemName: symbolName) != nil else { return nil }
		self.init(systemName: symbolName)
	}
}

struct TitleAuthorView: View {
	let book: Book
	let titleFont: Font
	let authorFont: Font

var body: some View {
	VStack(alignment: .leading) {
		Text(book.title)
			.font(titleFont).bold()
			.foregroundColor(.primary)
		Text(book.author)
			.font(authorFont)
			.foregroundColor(.secondary)
		}.lineLimit(2)
	}
}

///nil image initialiser  just for preview. Instead pass nil to PreviewProvider directly
extension Book.ImageView {
	init(title: String) {
		self.init(title: title, image: .constant(nil), cornerRadius: .init())
	}
}

struct Book_Preview: PreviewProvider {
	static var previews: some View {
		VStack(spacing: 80) {
			TitleAuthorView(book: Book(), titleFont: .title, authorFont: .title2)
			Book.ImageView(title: Book().title)
			Book.ImageView(title: "🖖")
			Book.ImageView(title: "4")
			Book.ImageView(title: "Q")
		}
	}
}

