//
//  ViewController.swift
//  myFilteredImage
//
//  Created by Hector Steven on 7/11/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import Photos
import ImageIO

class PhotoViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	
	private let filter = CIFilter(name: "CIColorControls")
	private let context = CIContext(options: nil)
	
	var ogImage: UIImage?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	
	@IBAction func addPhotoButton(_ sender: Any) {
		guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
			fatalError("AddPhoto error")
		}
		
		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .photoLibrary
		
		imagePicker.delegate = self
		present(imagePicker, animated: true)
	}
	

}


extension PhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[.originalImage] as? UIImage {
//			ogImage = image
			imageView?.image = image
		}
		
		picker.dismiss(animated: true)
	}
	
}
