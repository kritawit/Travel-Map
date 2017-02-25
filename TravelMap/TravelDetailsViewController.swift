//
//  TravelDetailsViewController.swift
//  TravelMap
//
//  Created by Header-Develop on 2/25/2560 BE.
//  Copyright © 2560 Header-Devs. All rights reserved.
//

import UIKit
import MapKit

class TravelDetailsViewController: UIViewController, MKMapViewDelegate {


    @IBOutlet weak var segmentedOUTLET: UISegmentedControl!
    @IBOutlet weak var myMapOUTLET: MKMapView!
    @IBOutlet weak var lblInfoOUTLET: UILabel!
    @IBOutlet weak var btnUnwindOUTLET: UIButton!

    var travelSource: String!
    var travelDestination: String!

    var myGeocoder = CLGeocoder()

    var myDistanceKm: Double!
    var myDistanceMiles: Double!

    var directionsResponse: MKRoute!
    var myRoute: MKRoute!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.myMapOUTLET.delegate = self

        //Set Pin For Source to Destination
        myGeocoder.geocodeAddressString(travelSource, completionHandler: {
            (placemark, error) in

            let request = MKDirectionsRequest()

            let sourcePlace = placemark?.first
            let sourceLocation = sourcePlace?.location


            request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (sourceLocation?.coordinate.latitude)!, longitude: (sourceLocation?.coordinate.longitude)!), addressDictionary: nil))

            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.title = self.travelSource

            sourceAnnotation.coordinate = (sourceLocation?.coordinate)!
            self.myMapOUTLET.addAnnotation(sourceAnnotation)

            self.myGeocoder.geocodeAddressString(self.travelDestination, completionHandler: {
                (placemarks, error) in

                let destinationPlace = placemarks?.first
                let destinationLocation = destinationPlace?.location

                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (destinationLocation?.coordinate.latitude)!, longitude: (destinationLocation?.coordinate.longitude)!), addressDictionary: nil))


                let destinationAnnotation = MKPointAnnotation()
                destinationAnnotation.title = self.travelDestination
                destinationAnnotation.coordinate = (destinationLocation?.coordinate)!


                let distanceMeters = sourceLocation?.distance(from: destinationLocation!)
                let distanceKm = distanceMeters! / 1000

                let distanceMiles = distanceKm * 0.621


                self.myDistanceKm = distanceKm
                self.myDistanceMiles = distanceMiles

                if self.segmentedOUTLET.selectedSegmentIndex == 0 {
                    self.lblInfoOUTLET.text = String.init(format: "Distance is %.2f km", distanceKm)

                } else {
                    self.lblInfoOUTLET.text = String.init(format: "Distance is %.2f miles", distanceMiles)
                }

                self.myMapOUTLET.addAnnotation(destinationAnnotation)

                request.requestsAlternateRoutes = true
                request.transportType = .automobile

                let directions = MKDirections(request: request)

                directions.calculate(completionHandler: { response, error in

                    if error == nil {

                        for route in response!.routes {
                            self.myMapOUTLET.add(route.polyline, level: MKOverlayLevel.aboveRoads)
                            self.myMapOUTLET.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                        }

                    }

                })

            })

        })



    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        if (overlay is MKPolyline) {
            if mapView.overlays.count == 1 {
                polylineRenderer.strokeColor =
                    UIColor.blue.withAlphaComponent(0.75)
                polylineRenderer.polyline.title = "Test"
                
            } else if mapView.overlays.count == 2 {
                polylineRenderer.strokeColor =
                    UIColor.green.withAlphaComponent(0.75)
                polylineRenderer.polyline.title = "Test"
            } else if mapView.overlays.count == 3 {
                polylineRenderer.strokeColor =
                    UIColor.red.withAlphaComponent(0.75)
                polylineRenderer.polyline.title = "Test"
            }
            polylineRenderer.lineWidth = 3
        }
        return polylineRenderer

    }



    @IBAction func segmentChanged(_ sender: UISegmentedControl) {

        if self.segmentedOUTLET.selectedSegmentIndex == 0 {
            self.lblInfoOUTLET.text = String.init(format: "Distance is %.2f km", myDistanceKm)

        } else {
            self.lblInfoOUTLET.text = String.init(format: "Distance is %.2f miles", myDistanceMiles)
        }

    }





}

