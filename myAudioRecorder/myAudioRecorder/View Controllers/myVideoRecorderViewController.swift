//
//  myVideoRecorderViewController.swift
//  myAudioRecorder
//
//  Created by Hector Steven on 7/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import AVFoundation

class myVideoRecorderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		
    }
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		checkStatus()
	}
    
	func checkStatus() {
		
		
		let status = AVCaptureDevice.authorizationStatus(for: .video)
		
		switch status {
		case .notDetermined:
			// we have not asked the user for permission
			// request access
			
			AVCaptureDevice.requestAccess(for: .video) { (granted) in
				if granted == false {
					fatalError("Please request user enable camera in Settings > Privacy")
				}
				
				DispatchQueue.main.async {
					self.showCamera()
				}
			}
			
			
		case .restricted:
			// we don't have permission from the user because of parental controls
			fatalError("Please inform the user they cannot use app due to parental restrictions")
		case .denied:
			// we asked for permission, but the user said no
			fatalError("Please request user to enable camera usage in Settings > Privacy")
		case .authorized:
			// we asked for permission and they said yes.
			showCamera()
		}
		
		
		
	}
	
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
