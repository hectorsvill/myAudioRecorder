//
//  ViewController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MyAudioRecorderViewController: UIViewController {
	lazy private var recorder = Recorder()
	
	var recordingList: [String] = []
	
	@IBOutlet var playToggleButton: UIButton!
	@IBOutlet var recordedNameLabel: UILabel!
	@IBOutlet var timerLabel: UILabel!
	@IBOutlet var slider: UISlider!
	
	@IBOutlet var tableView: UITableView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecording))
		
		playToggleButton.setTitle("Play", for: .normal)
	}
	
	@objc func addRecording() {
		recorder.toggleRecording()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopRecording))
	}
	
	@objc func stopRecording() {
		recorder.stop()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecording))
	}
	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		
	}
	
	@IBAction func sliderValueChanged(_ sender: Any) {
	}
	

}



extension MyAudioRecorderViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
		
		cell.textLabel?.text = "\(indexPath.row)"
		return cell
	}
	
	
}
