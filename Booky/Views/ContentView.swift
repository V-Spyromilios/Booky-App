//
//  ContentView.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import SwiftUI

struct ContentView: View {
@EnvironmentObject var library : Library
@State var addingNewBook: Bool = false

var body: some View {
		NavigationView {
			List {
				Button {
				  addingNewBook = true
				} label: {
				  Spacer()
				  VStack(spacing: 6) {
					Image(systemName: "books.vertical")
					  .font(.system(size: 60))
					Text("Add New Book")
					  .font(.title2)
				  }
					Spacer()
				}
				.buttonStyle(.borderless)
				.padding(.vertical, 8)
				.sheet(isPresented: $addingNewBook) { AddBookView() }
				ForEach(Section.allCases, id: \.self) { SectionView(section: $0) }
			}.navigationTitle("Kleistrasse Library")
			.listStyle(.insetGrouped)
			.toolbar(content: EditButton.init)
		}.navigationViewStyle(StackNavigationViewStyle()) //!
		}
}

private struct BookRowView: View {
@ObservedObject var book: Book
@EnvironmentObject var library: Library

var body: some View {
	NavigationLink(destination: DetailedView(book: book)) {
		HStack(spacing: 15) {

		Book.ImageView(title: book.title, size: 80, image: $library.images[book], cornerRadius: 16)
		TitleAuthorView(book: book, titleFont: .title2, authorFont: .title3)
		}
	}.padding(.vertical)
}
}

private struct SectionView: View {
let section: Section
@EnvironmentObject var library: Library

var title: String {
	switch section {
	case .unread:
		return ("Unread")
	case .finished:
		return("Finished")
	}
}
	var body: some View {
		if let books = library.sortedBooks[section] {
			SwiftUI.Section { ForEach(books) { book in BookRowView(book: book)
					.swipeActions(edge: .leading) {
						Button {
							withAnimation {
								book.readMe.toggle()
								library.sortBooks()
							}
						} label: {
						book.readMe ? Label("Finished", systemImage: "bookmark.slash") : Label("Unread", systemImage: "bookmark")
						}
						}.tint(.mint)
					.swipeActions(edge: .trailing) {
						Button(role: .destructive) {
							withAnimation {
							library.deleteBook(book: book)
							}
						} label: {
							Label("Delete", systemImage: "trash")
						}.labelStyle(.iconOnly)
					}
			}
			.onMove {
				indexes, newOffset in	//whereIsNow, WhereWillGo
				library.moveBook(oldOffSets: indexes, newOffset: newOffset, section: section)
			}
			} header: {
				ZStack {
					Text(title)
						.font(.body)
						.foregroundColor(.primary)
				}
				.listRowInsets(.init())
				
			}
		}
	}
}

extension View {
	var previewAllColorSchemes: some View {
		ForEach(ColorScheme.allCases, id: \.self, content: preferredColorScheme) }
}

struct ContentView_Previews: PreviewProvider {
static var previews: some View {
	ContentView()
		.environmentObject(Library())
		.previewAllColorSchemes
		.previewInterfaceOrientation(.portrait)
	
		ContentView()
		.environmentObject(Library())
		.previewInterfaceOrientation(.landscapeLeft)
	}
}
