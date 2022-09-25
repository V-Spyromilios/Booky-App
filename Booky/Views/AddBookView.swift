//
//  AddBookView.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import SwiftUI

struct AddBookView: View {
@EnvironmentObject var library: Library
@Environment (\.dismiss) var dismiss
@FocusState private var titleIsFocused: Bool
@FocusState private var authorIsFocused: Bool
@FocusState private var reviewIsFocused: Bool
@ObservedObject var book = Book(title: "", author: "", date: Date())
@State var image: Image? = nil

var body: some View {
	NavigationView {
	VStack {
		HStack {
			TextField("Add Title (Required)", text: $book.title).padding()
				.focused($titleIsFocused)
				.disableAutocorrection(true)
		}
		Divider()
		HStack {
			TextField("Add Author (Required)", text: $book.author).padding()
				.focused($authorIsFocused)
//					.textInputAutocapitalization(.words)
				.disableAutocorrection(true)
		}
		Divider()
		HStack {
			TextField("Add Review", text: $book.review).padding()
				.focused($reviewIsFocused)
				.textInputAutocapitalization(.sentences)
				.disableAutocorrection(true)
			}
		Divider()
		BookImageView(book: book, image: $image).padding(.top)
	Spacer()
	}
	.navigationBarTitle("Add New Book")
	.toolbar {
		ToolbarItemGroup(placement: .bottomBar) {
				Button("Cancel") {
					dismiss()
				}
				.buttonStyle(.bordered)
				.tint(.secondary)
				.font(.body)
				.padding()

				Button("Save to Library") {
					library.addNewBook(book: book, image: image)
					dismiss()
				}
				.buttonStyle(.bordered)
				.tint(.mint)
				.font(.body)
				.padding()
				.disabled([book.title, book.author]
					.contains(where: \.isEmpty)
				)
			}
		}
	}
}
}


struct AddBookView_Previews: PreviewProvider {
	static var previews: some View {
		AddBookView()
	}
}
