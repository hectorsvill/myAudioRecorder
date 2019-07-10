//
//  ViewController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MyAudioRecorderViewController: UIViewController {
	private var recorder: Recorder?
	private var player: Player?
	
	var recordingList: [URL] = []
	
	@IBOutlet var playToggleButton: UIButton!
	@IBOutlet var recordedNameLabel: UILabel!
	@IBOutlet var timerLabel: UILabel!
	@IBOutlet var slider: UISlider!
	
	@IBOutlet var tableView: UITableView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
		
		playToggleButton.setTitle("Play", for: .normal)
		playToggleButton.isEnabled = false
	}
	
	@objc func startRecorder() {
		recorder = Recorder()
		recorder?.toggleRecording()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopRecording))
	}
	
	@objc func stopRecording() {
		guard let fileUrl = recorder?.fileUrl else { return }
		
		recordingList.append(fileUrl)
		self.tableView.reloadData()
		
		recorder?.stop()
		recorder = nil
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		if let _ = player {
			guard let url = recordedNameLabel.text else { return }
			
			
			player = Player(forResource: url)
			guard let duration  = player?.duration else { return }
			slider.maximumValue = Float(duration)
			print("The duaration is : ",duration)
			
			
			
			
//			playToggleButton.setTitle("Pause", for: .normal)
		} else {
			player?.pause()
			playToggleButton.setTitle("Pause", for: .normal)
		}
	}
	
	@IBAction func sliderValueChanged(_ sender: Any) {
		
	}
	

}



extension MyAudioRecorderViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recordingList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
		let record = recordingList[indexPath.row]
		cell.textLabel?.text = "\(record)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let record = recordingList[indexPath.row]
		recordedNameLabel.text = "\(record)"
		playToggleButton.isEnabled = true
		
		print(record)
		
	}
}

