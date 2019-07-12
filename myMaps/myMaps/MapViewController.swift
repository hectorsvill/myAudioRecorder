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
		requestLocationAccess()
		
		
		mapView.delegate = self
		mapView?.addAnnotations(places)
		
		let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100)}
		mapView?.addOverlays(overlays)

		
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
		if annotation is MKUserLocation { return nil }
		
		let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "someAnnotation", for: annotation) as! MKMarkerAnnotationView
		annotationView.glyphImage = UIImage(named: "QuakeIcon")
		annotationView.glyphTintColor = .white
		annotationView.markerTintColor = .black
		annotationView.canShowCallout = true
		
		let dv = DetailView(frame: .zero)
		dv.backgroundColor = .red
		annotationView.detailCalloutAccessoryView = dv
		

		return annotationView
	}
	

	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let render = MKCircleRenderer(overlay: overlay)
		render.fillColor = UIColor.black.withAlphaComponent(0.5)
		render.strokeColor = .brown
		render.lineWidth = 2
		
		return render
		
	}


	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		guard let title = view.annotation?.title as? String else { return }
		
		print(title)
	}
	
	
}







