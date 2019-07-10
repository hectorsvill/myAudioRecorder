//
//  ViewController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class MyAudioRecorderViewController: UIViewController {
	let mediaController = MediaController()
	
	private var recorder: Recorder?
	private var player: Player?
	
	@IBOutlet var playToggleButton: UIButton!
	@IBOutlet var recordedNameLabel: UILabel!
	@IBOutlet var timerLabel: UILabel!
	@IBOutlet var slider: UISlider!
	
	@IBOutlet var tableView: UITableView!
	
	
	var currentMediaName: String {
		return recordedNameLabel.text ?? ""
	}
	
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
	
	
	private func getMediaName() {
		let alertController = UIAlertController(title: "My Media Recorder", message: "Name This Media", preferredStyle: .alert)
		
		alertController.addTextField()
		alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
			if let nametext = alertController.textFields![0].text, !nametext.isEmpty {
				self.recordedNameLabel.text = nametext
			}
		}))
		
		present(alertController, animated: true)
	}
	
	@objc func startRecorder() {
		getMediaName()
		
		//setup Recorder
		recorder = Recorder()
		recorder?.startRecord(with: currentMediaName)

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopRecording))
	}
	
	@objc func stopRecording() {
		
		recorder?.stop()
		recorder = nil
		
		mediaController.addNewMedia(name: currentMediaName, type: "audio")
		recordedNameLabel.text = ""
		self.tableView.reloadData()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(startRecorder))
	}
	
	@IBAction func playToggleButtonPressed(_ sender: UIButton) {
		guard let name = recordedNameLabel.text else { return }
		
		
		playToggleButton.setTitle(playToggleButton.titleLabel?.text == "Play" ? "Pause" : "Play", for: .normal)
		
//		guard let url = recordedNameLabel.text else { return }
//
		player = Player(name: name)
		player?.setupPlayer()
		
		
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
		let media = mediaController.allMeddia[indexPath.row]
		recordedNameLabel.text = "\(media.name!)"
		
		
	}
}

