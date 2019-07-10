//
//  Player.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import AVFoundation

class Player: NSObject {
	let name: String
	private var audioPlayer: AVAudioPlayer?
	private var timer: Timer?

	init(name: String) {
		self.name = name
	}
	
	func setupPlayer() {
		let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		
		let url = documentsDirectory.appendingPathComponent(name).appendingPathExtension("caf")
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: url)
		} catch {
			NSLog("audioPlayer: \(error)")
		}
		audioPlayer!.play()
	}
	
	var isPlaying: Bool {
		return audioPlayer?.isPlaying ?? false
	}
	
	var elapsedTime: TimeInterval? {
		return audioPlayer?.currentTime
	}
	
	var duration: TimeInterval? {
		return audioPlayer?.duration
	}
	
	func play() {
		audioPlayer?.play()
		//starttimeer
	}
	
	func pause() {
		audioPlayer?.pause()
	}
}

extension Player: AVAudioPlayerDelegate {
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
	}
}
