//
//  ViewController.swift
//  MapKit Lab
//
//  Created by Christian Hurtado on 2/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit

class SchoolMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var userTrackingButton: MKUserTrackingButton!
    
    private var annotations = [MKPointAnnotation]()
    
    private let locationSession = CoreLocationSession()
    
    private var isShowingNewAnnotations = false
    
    var schools = [School]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 370, y: 30, width: 40, height: 40))
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView
        mapView.delegate = self
        
        SchoolAPIClient.getSchools { (result) in
            switch result{
            case .failure(let error):
                print("error \(error)")
            case .success(let schools):
                self.schools = schools
                self.loadMap()
            }
        }
    }
    
    private func loadMap(){
        let annotations = makeAnnotations()
        mapView.addAnnotations(annotations)
        let coordinates = CLLocationCoordinate2DMake(40.7128, -74.0060)
        mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
    }
    
    private func makeAnnotations() -> [MKPointAnnotation]{
        var annotations = [MKPointAnnotation]()
        for schools in schools{
            let annotation = MKPointAnnotation()
            annotation.title = schools.schoolName
            annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(Double(schools.latitude)!), CLLocationDegrees(Double(schools.longitude)!))
            annotations.append(annotation)
        }
        isShowingNewAnnotations = true
        self.annotations = annotations
        return annotations
        
    }
    
}
    extension SchoolMapViewController: MKMapViewDelegate{
                
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else { return nil }
            
            let identifier = "annotationView"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil{
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.glyphImage = UIImage(named: "duck")
                annotationView?.glyphTintColor = .systemYellow
                annotationView?.markerTintColor = .systemBlue
                // annotationView?.glyphText = "iOS 6.3"
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
            
        }
        
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            if isShowingNewAnnotations {
                mapView.showAnnotations(annotations, animated: false)
            }
            isShowingNewAnnotations = false
        }
        
}
