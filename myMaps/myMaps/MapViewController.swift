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
		
		//mapView.register(MKAnnotation.self, forAnnotationViewWithReuseIdentifier: "annotationView")
		
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
		if annotation is MKUserLocation {
			return nil
		}
		
		let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
		
		
		return annotationView
	}
	
	
	
}







