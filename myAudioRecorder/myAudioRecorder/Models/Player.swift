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
	
	
	private var audioPlayer: AVAudioPlayer!
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
}
