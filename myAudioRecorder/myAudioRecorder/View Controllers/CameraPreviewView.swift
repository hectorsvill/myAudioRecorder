//
//  CameraPreviewView.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewView: UIView {
	
	override class var layerClass: AnyClass {
		return AVCaptureVideoPreviewLayer.self
	}
	
	var videoPlayerView: AVCaptureVideoPreviewLayer {
		return layer as! AVCaptureVideoPreviewLayer
	}
	
	var session: AVCaptureSession? {
		get { return videoPlayerView.session }
		set { videoPlayerView.session = newValue }
	}
}
