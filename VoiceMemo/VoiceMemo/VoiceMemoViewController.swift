//
//  ViewController.swift
//  VoiceMemo
//
//  Created by Hector Steven on 7/11/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class VoiceMemoViewController: UIViewController {
	@IBOutlet var nameTextField: UITextField!
	@IBOutlet var recordLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func recordButtonPressed(_ sender: Any) {
		guard let name = nameTextField.text else {
			print("empty Name")
			return
		}
		print(name)
		
		nameTextField.text = ""
	}
	
	
	@IBAction func playButtonPressed(_ sender: Any) {
		print("play")
		
		
		
	}
	
}

