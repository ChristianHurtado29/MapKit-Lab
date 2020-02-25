//
//  ViewController.swift
//  MapKit Lab
//
//  Created by Christian Hurtado on 2/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var userTrackingButton: MKUserTrackingButton!
    
    private var annotations = [MKPointAnnotation]()
    
    private let locationSession = CoreLocationSession()
    
    private var isShowingNewAnnotations = false

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }


}

