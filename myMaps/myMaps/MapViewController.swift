//
//  ViewController.swift
//  myMaps
//
//  Created by Hector Steven on 7/11/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

	let locationManager = CLLocationManager()
	var places: [Place] = Place.getPlaces()
	
	@IBOutlet var mapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self
		mapView?.addAnnotations(places)
		
		mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "someAnnotation")
		
	}
	
	@IBAction func postButtonPressed(_ sender: Any) {
		// make a post
		print("post")
	
	}
	
	
	func requestLocationAccess() {
		let status = CLLocationManager.authorizationStatus()
		
		switch status {
		case .authorizedAlways, .authorizedWhenInUse:
			return
		case .denied, .restricted:
			print("location access denied")
		default:
			locationManager.requestWhenInUseAuthorization()
		}
		
	}
}

extension MapViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "someAnnotation", for: annotation) as! MKMarkerAnnotationView
		annotationView.glyphImage = UIImage(named: "QuakeIcon")
		annotationView.glyphTintColor = .black
		annotationView.canShowCallout = true
		
		
		guard let place = annotation as? Place else { return nil }
		
//		annotationView.glyphText = "\(place.title!)"
		
		
		return annotationView
	}
	
	
	
}







