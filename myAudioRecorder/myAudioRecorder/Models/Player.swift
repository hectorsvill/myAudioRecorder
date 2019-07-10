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
		
		let audioUrl = Bundle.main.url(forResource: forResource, withExtension: "caf")!
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
		} catch {
			NSLog("audioPlayer: \(error)")
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
