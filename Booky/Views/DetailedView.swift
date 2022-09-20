//
//  DetailedView.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import SwiftUI
import class PhotosUI.PHPickerViewController

struct DetailedView: View {
@EnvironmentObject var library: Library
@ObservedObject var book: Book
@State var showingPicker = false
@State var deleteImage = false
@FocusState private var isFocused: Bool

var body: some View {
	VStack(alignment: .leading) {
		HStack() {
			Button {
				book.readMe.toggle()
			}
			label: {
				Image(systemName:book.readMe ? "bookmark.fill" : "bookmark").font(.system(size: 48, weight: .light))
			}

			TitleAuthorView(book: book, titleFont: .title, authorFont: .title2).padding()
			Spacer()
		}
		Divider()
		
		HStack(alignment: .top) {
			TextField("Review...", text: $book.review)
				.font(.subheadline)
				.padding(.horizontal)
				.textFieldStyle(.roundedBorder)
				.focused($isFocused)
				.textInputAutocapitalization(.sentences)
				.disableAutocorrection(false)

			if (isFocused) {
				Spacer()
				Button{ isFocused = false }
				label: {
					Label("OK", systemImage: "nil")
				}.padding(.horizontal)
			}
		}

		BookImageView(book: book, image: $library.images[book], showingPicker: showingPicker, deleteImage: deleteImage)
		Spacer()
		}
	.onDisappear {
		withAnimation {
		library.sortBooks()
		}
	}
}
}

struct DetailedView_Previews: PreviewProvider {
	static var previews: some View {
			DetailedView(book: .init())
				.environmentObject(Library())
				.previewAllColorSchemes
				.previewInterfaceOrientation(.landscapeLeft)
	}
}
