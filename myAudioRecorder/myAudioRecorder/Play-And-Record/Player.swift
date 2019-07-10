//
//  Player.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import AVFoundation

class Player: NSObject {
	let forResource: String
	private var audioPlayer: AVAudioPlayer?
	private var timer: Timer?

	init(forResource: String) {
		self.forResource = forResource
	}
	
	func setupPlayer(forResource: String) {
		print(forResource)
		if let audioUrl = Bundle.main.url(forResource: "35B50F4F-B903-47E4-8C8E-52B68BAB5E36", withExtension: ".caf") {
			do {
				audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
			} catch {
				NSLog("audioPlayer: \(error)")
			}
		} else {
			NSLog("\n\nsetupPlayer Could not find audioUrl forResource: \(forResource)\n\n")
		}
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
