//
//  TravelDetailsViewController.swift
//  TravelMap
//
//  Created by Header-Develop on 2/25/2560 BE.
//  Copyright © 2560 Header-Devs. All rights reserved.
//

import UIKit
import MapKit

class TravelDetailsViewController: UIViewController {


    @IBOutlet weak var myMapOUTLET: MKMapView!
    @IBOutlet weak var lblInfoOUTLET: UILabel!
    @IBOutlet weak var btnUnwindOUTLET: UIButton!

    var travelSource: String!
    var travelDestination: String!

    var myGeocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()

        myGeocoder.geocodeAddressString(travelSource, completionHandler: {
            (placemark, error) in

            let sourcePlace = placemark?.first
            let sourceLocation = sourcePlace?.location

            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.coordinate = (sourceLocation?.coordinate)!

            self.myMapOUTLET.addAnnotation(sourceAnnotation)

            self.myGeocoder.geocodeAddressString(self.travelDestination, completionHandler: {
                (placemarks, error) in

                let destinationPlace = placemarks?.first
                let destinationLocation = destinationPlace?.location

                let destinationAnnotation = MKPointAnnotation()
                destinationAnnotation.coordinate = (destinationLocation?.coordinate)!
                self.myMapOUTLET.addAnnotation(destinationAnnotation)
            })

        })
    }



}

