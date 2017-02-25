//
//  TravelSetupViewController.swift
//  TravelMap
//
//  Created by Header-Develop on 2/25/2560 BE.
//  Copyright © 2560 Header-Devs. All rights reserved.
//

import UIKit

class TravelSetupViewController: UIViewController {


    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtTravleSource: UITextField!
    @IBOutlet weak var txtTravelDestination: UITextField!
    @IBOutlet weak var btnSubmitOUTLET: UIButton!



    override func viewDidLoad() {

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! TravelDetailsViewController

        destinationViewController.travelSource = txtTravleSource.text
        destinationViewController.travelDestination = txtTravelDestination.text

    }

    @IBAction func unwindChooseNewTripACTION(usingSeque: UIStoryboardSegue) {



    }


}
