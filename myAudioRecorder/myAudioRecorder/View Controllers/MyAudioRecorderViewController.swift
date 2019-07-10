//
//  ViewController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MyAudioRecorderViewController: UIViewController {
//	let recordController = RecordController()
	
	private var recorder: Recorder?
	private var player: Player?
	
	@IBOutlet var playToggleButton: UIButton!
	@IBOutlet var recordedNameLabel: UILabel!
	@IBOutlet var timerLabel: UILabel!
	@IBOutlet var slider: UISlider!
	
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	func setupViews() {
//		recordController.fetchRecords()
		tableView.delegate = self
		tableView.dataSource = self
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	
	private func getMediaName() -> String {
		var name = ""
		
		let alertController = UIAlertController(title: "My Media Recorder", message: "Name This Media", preferredStyle: .alert)
		
		alertController.addTextField()
		alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			if let nametext = alertController.textFields![0].text {
				name = nametext
				
				self.recordedNameLabel.text = name
			}
		}))
		
		present(alertController, animated: true)
		
		return name
	}
	
	@objc func startRecorder() {
		let name = getMediaName()
		
		//setup Recorder
		recorder = Recorder()
		recorder?.startRecord(with: name)

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopRecording))
	}
	
	@objc func stopRecording() {
//		guard let fileUrl = recorder?.name else { return }
//		let url = "\(fileUrl)"
//
//		recordController.addRecord(url: url)
//
//		recorder?.stop()
//		recorder = nil
//		self.tableView.reloadData()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		guard recordedNameLabel.text?.isEmpty  == false else { return }
		
		
		playToggleButton.setTitle(playToggleButton.titleLabel?.text == "Play" ? "Pause" : "Play", for: .normal)
		
//		guard let url = recordedNameLabel.text else { return }
//
//		player = Player(forResource: url)
//		player?.setupPlayer(forResource: url)
//		player?.play()
		
	}
	
	@IBAction func sliderValueChanged(_ sender: Any) {
		
	}
	

}



extension MyAudioRecorderViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5 //recordController.records.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
//		let record = recordController.records[indexPath.row]
//		cell.textLabel?.text = "\(record.url!)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let record = recordController.records[indexPath.row]
//		recordedNameLabel.text = "\(record.url!)"
//		playToggleButton.isEnabled = true
	}
}

