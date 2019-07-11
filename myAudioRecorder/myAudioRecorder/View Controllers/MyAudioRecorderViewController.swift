//
//  ViewController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

//mediaController.addNewMedia(name: "", type: "audio")

class MyAudioRecorderViewController: UIViewController {
	let mediaController = MediaController()
	
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mediaController.fetchTracks()
	}
	
	
	func setupViews() {
		mediaController.fetchTracks()
		tableView.delegate = self
		tableView.dataSource = self
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(getMediaName))
		NotificationCenter.default.addObserver(self, selector: #selector(timerDidChange), name: .timerChangedValue, object: nil)
	}
	
	@objc func timerDidChange() {
		
		if let elapsedTime = player?.elapsedTime {
			slider.value = Float(elapsedTime)
			print("TimerChanged!TimerChanged!TimerChanged!TimerChanged!TimerChanged!")
			
		}
		
	}
	
	@objc func getMediaName() {
		let alertController = UIAlertController(title: "My Media Recorder", message: "Name This Media", preferredStyle: .alert)
	
		alertController.addTextField()
		alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {[unowned alertController] _ in
			if let nametext = alertController.textFields![0].text, !nametext.isEmpty {
				DispatchQueue.main.async {
					self.recordedNameLabel.text = nametext
					self.startRecorder(name: nametext)					
				}
			}
		}))
	
	
		present(alertController, animated: true)
	
	}
	
	@objc func startRecorder(name: String) {
		//setup Recorder
		self.recorder = Recorder()
		self.recorder?.startRecord(with: name)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopRecording))
	}
	
	@objc func stopRecording() {
		recorder?.stop()
		recorder = nil
		
		let text = recordedNameLabel.text!
		mediaController.addNewMedia(name: text, type: "audio")
		recordedNameLabel.text = ""
		tableView.reloadData()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	

	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		playToggleButton.setTitle(playToggleButton.titleLabel?.text == "Play" ? "Pause" : "Play", for: .normal)
		
		guard let name = recordedNameLabel.text else { return }
		
		if let _ = player {
			resetPlayer()
			
		} else {
			player = Player(name: name)
			player?.setupPlayer()
			
			// set timer duration
			// set slider duration
			if let duration = player?.duration {
				slider.maximumValue = Float(duration)
			}
			
		}
	}
	
	@IBAction func sliderValueChanged(_ sender: Any) {
	}
	

}

extension MyAudioRecorderViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mediaController.allMeddia.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
		
		let media = mediaController.allMeddia[indexPath.row]
		
		cell.textLabel?.text = "\(media.name!)"
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let name = mediaController.allMeddia[indexPath.row].name else { return }
		recordedNameLabel.text = "\(name)"
		
		// Mark: fix this
		resetPlayer()
	}
	
	private func resetPlayer() {
		if let player = player {
			player.pause()
			self.player = nil
			slider.value = Float(0)
			playToggleButton.setTitle(playToggleButton.titleLabel?.text == "Play" ? "Pause" : "Play", for: .normal)
			
		}
	}
	
}

