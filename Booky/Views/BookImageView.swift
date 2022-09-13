//
//  BookImageView.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import class PhotosUI.PHPickerViewController
import SwiftUI

struct BookImageView: View {
	@ObservedObject var book: Book
	@Binding var image: Image?
	@State var showingPicker: Bool = false
	@State var deleteImage: Bool = false

	var body: some View {
		VStack {
		Book.ImageView(title: book.title, image: $image, cornerRadius: 16).padding(.horizontal)
		HStack(alignment: .center) {
			if (self.image == nil) {
				Spacer()
			}
			Button("Edit") { showingPicker = true }
					.buttonStyle(.bordered)
					.tint(.accentColor)
					.font(.body)
					.padding()

			if (self.image != nil) {
				Button{ deleteImage = true }
					label: {
						Label("Delete", image: "trash.circle")
					}
					.buttonStyle(.bordered)
					.tint(.red)
					.font(.body)
					.padding()
				}
		}
		.sheet(isPresented: $showingPicker) { PHPickerViewController.View(image: $image) }
		.confirmationDialog("Delete image of \(book.title) ?", isPresented: $deleteImage) { Button("Delete", role: .destructive) {image = nil }
			} message: { Text("Delete image of \"\(book.title)\" ?")}
		}
	}
}

struct BookImageView_Previews: PreviewProvider {
	static var previews: some View {
		BookImageView(book: .init(), image: .constant(nil))
	}
}
