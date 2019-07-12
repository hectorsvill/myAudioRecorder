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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	
	@IBAction func addPhotoButton(_ sender: Any) {
		imageView.image = nil
		guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
			fatalError("AddPhoto error")
		}
		
		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .photoLibrary
		
		imagePicker.delegate = self
		present(imagePicker, animated: true)
	}
	
	private func filter(image: UIImage) -> UIImage {
		guard let cgImage = image.cgImage else { return image}
		let ciImage = CIImage(cgImage: cgImage)
		filter?.setValue(ciImage, forKey: kCIInputImageKey)
		filter?.setValue(1.05, forKey: kCIInputSaturationKey)
		filter?.setValue(1, forKey: kCIInputBrightnessKey)
		filter?.setValue(3, forKey:  kCIInputContrastKey)
		
		guard let outputImage = filter?.outputImage else {
			NSLog("error")
			return image
		}
		
		guard let outputCGImage = context.createCGImage(outputImage, from: outputImage.extent) else { return image}
		
		
		
		return UIImage(cgImage: outputCGImage)
	}
	

}


extension PhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true)
		if let image = info[.originalImage] as? UIImage {
			imageView?.image = filter(image: image)
		}
		
	}
	
}
