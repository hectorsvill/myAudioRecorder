//
//  Recorder.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/9/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import AVFoundation

class Recorder: NSObject {
	private var audioRecorder: AVAudioRecorder?
	var fileUrl: URL?
	
	var isRecording: Bool {
		guard let audioRecorder = audioRecorder else { return false }
		return audioRecorder.isRecording
	}
	
	override init() {
		super.init()
	}
	
	func record() {
		let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		
		let name = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime])
		fileUrl = documentDirectory.appendingPathComponent(name).appendingPathExtension("caf")
		
		let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!
		
		do {
			guard let fileUrl = fileUrl else { return }
			audioRecorder = try AVAudioRecorder(url: fileUrl, format: format)
//			audioRecorder?.delegate = self
		} catch {
			NSLog("Error trying to AVAudioRecorder: \(error)")
		}
		
		guard let audioRecorder = audioRecorder else { return }
		audioRecorder.record()
		
		
	}
	
	func stop() {
		if let audioRecorder = audioRecorder {
			audioRecorder.stop()
			self.audioRecorder = nil
		}
	}
	
	func toggleRecording() {
		if isRecording {
			stop()
		} else {
			record()
		}
	}
}

extension Recorder: AVAudioRecorderDelegate {
	func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
		if let error = error {
			print("audioRecorderEncodeErrorDidOccur: \(error)")
		}
		
		
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		
	}
	
}
