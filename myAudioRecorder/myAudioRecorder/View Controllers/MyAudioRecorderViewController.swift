//
//  ViewController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MyAudioRecorderViewController: UIViewController {
	let recordController = RecordController()
	
	private var recorder: Recorder?
	private var player: Player?
	
	
	
	@IBOutlet var playToggleButton: UIButton!
	@IBOutlet var recordedNameLabel: UILabel!
	@IBOutlet var timerLabel: UILabel!
	@IBOutlet var slider: UISlider!
	
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		recordController.fetchRecords()
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
		guard let fileUrl = recorder?.name else { return }
		let url = "\(fileUrl)"
		
		recordController.addRecord(url: url)
		
		recorder?.stop()
		recorder = nil
		self.tableView.reloadData()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		guard let url = recordedNameLabel.text else { return }
		
		player = Player(forResource: url)
		player?.setupPlayer(forResource: url)
		player?.play()
			
	}
	
	@IBAction func sliderValueChanged(_ sender: Any) {
		
	}
	

}



extension MyAudioRecorderViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return recordController.records.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
		let record = recordController.records[indexPath.row]
		cell.textLabel?.text = "\(record.url!)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let record = recordController.records[indexPath.row]
		recordedNameLabel.text = "\(record.url!)"
		playToggleButton.isEnabled = true
	}
}

