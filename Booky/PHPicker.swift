//
//  PHPicker.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import SwiftUI
import PhotosUI

extension PHPickerViewController {
	struct View {
		@Binding var image: Image?
	}
}

// MARK: - UIViewControllerRepresentable
extension PHPickerViewController.View: UIViewControllerRepresentable {
	func makeCoordinator() -> some PHPickerViewControllerDelegate {
		PHPickerViewController.Delegate(image: $image)
	}

	func makeUIViewController(context: Context) -> PHPickerViewController {
		let picker = PHPickerViewController(configuration: .init())
		picker.delegate = context.coordinator
		return picker
	}

	func updateUIViewController(_: UIViewControllerType, context _: Context) { }
}

// MARK: - PHPickerViewControllerDelegate
extension PHPickerViewController.Delegate: PHPickerViewControllerDelegate {
	func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		results.first?.itemProvider.loadObject(ofClass: UIImage.self) {
			image, error in DispatchQueue.main.async {
				if let uiImage = image as? UIImage {
					self.image = Image(uiImage: uiImage)
				}
			}
		}
		picker.dismiss(animated: true)
	}
}

// MARK: - private
private extension PHPickerViewController {
	final class Delegate {
		init(image: Binding<Image?>) {
			_image = image
		}
		@Binding var image: Image?
	}
}

