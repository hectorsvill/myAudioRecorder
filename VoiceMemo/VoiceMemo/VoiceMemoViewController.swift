//
//  ViewController.swift
//  VoiceMemo
//
//  Created by Hector Steven on 7/11/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceMemoViewController: UIViewController {
	private var recorder: Recorder?
	
	@IBOutlet var nameTextField: UITextField!
	@IBOutlet var recordLabel: UILabel!
	
	var currentRecord: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(audioRecorderDidFinishRecording), name: .audioRecorderDidFinishRecording, object: nil)
		
	}
	
	

	@IBAction func recordButtonPressed(_ sender: Any) {
		guard let name = nameTextField.text else {
			print("empty Name")
			return
		}
		
		currentRecord = name
		startRecording()
	}
	
	private func startRecording() {
		guard let currentRecord = currentRecord else { return }
		
		recorder = Recorder()
		recorder?.startRecord(with: currentRecord)
		
		Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (_) in
			self.recorder?.stop()
		}
	}
	
	
	@IBAction func playButtonPressed(_ sender: Any) {
		print("play")
	}
	
	
	@objc func audioRecorderDidFinishRecording() {
		recordLabel.text = currentRecord!
		nameTextField.text = ""
	}
}

