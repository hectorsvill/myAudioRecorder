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
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	
	private func getMediaName() -> String?{
		let alertController = UIAlertController(title: "My Media Recorder", message: "Name This Media", preferredStyle: .alert)
		
		var str: String?

		alertController.addTextField()
		alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			if let nametext = alertController.textFields![0].text, !nametext.isEmpty {
				self.recordedNameLabel.text = nametext
				str = nametext
			}
		}))
		
		present(alertController, animated: true)
		return str
	}
	
	@objc func startRecorder() {
		let name = getMediaName()!
		
		//setup Recorder
		recorder = Recorder()
		recorder?.startRecord(with: name)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopRecording))
	}
	
	@objc func stopRecording() {
		recorder?.stop()
		recorder = nil
		
		recordedNameLabel.text = ""
		self.tableView.reloadData()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		playToggleButton.setTitle(playToggleButton.titleLabel?.text == "Play" ? "Pause" : "Play", for: .normal)
		
		guard let name = recordedNameLabel.text else { return }
		
		if let player = player {
			player.pause()
			
		} else {
			player = Player(name: name)
			player?.setupPlayer()
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
	}
}

