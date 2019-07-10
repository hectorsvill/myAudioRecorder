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
		if let fileUrl = recorder?.fileUrl {
			recordingList.append(fileUrl)
			print(fileUrl)
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
				
			}
			navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopRecording))
		}
	}
	
	@objc func stopRecording() {
		
		recorder?.stop()
		recorder = nil
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		
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
		
	}
}

