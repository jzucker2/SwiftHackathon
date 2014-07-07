//
//  FirstViewController.swift
//  SwiftHackathon
//
//  Created by Jordan Zucker on 6/27/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, BeaconManagerDelegate {

    var beaconManager: BeaconManager?
    var scanMode: Bool = false

    var scanButton: UIButton?
    var regionStatusLabel: UILabel?
    var beaconDistanceLabel: UILabel?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
//        label.center = CGPointMake(160, 284)
//        label.text = "I am a test label!"
//        self.view.addSubview(label)

        self.beaconManager = sharedBeaconManager
        if !CLLocationManager.locationServicesEnabled() {
            // TODO: Alert, once alerts work without crashing app
        }

        // Make scan button (antenna)
//        let scanButton: UIButton = self.makeMenuButton(image: scanImgOff, left:false)
        //let scanButton:UIButton = UIButton(frame:CGRectMake(100, 100, 200, 21))
        let scanButton:UIButton = UIButton()
        scanButton.backgroundColor = UIColor.redColor()
        //let scanButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom)
        scanButton.frame = CGRectMake(100, 100, 200, 21)
        scanButton.setTitle("Scan", forState: UIControlState.Normal)
        scanButton.addTarget(self, action: "scanButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.scanButton = scanButton
        self.view.addSubview(scanButton)

        let regionLabel:UILabel = UILabel()
        regionLabel.frame = CGRectMake(100, 300, 200, 21)
        regionLabel.text = "hey"
        regionStatusLabel = regionLabel
        self.view.addSubview(regionStatusLabel)

        let rangeDistanceLabel:UILabel = UILabel()
        rangeDistanceLabel.frame = CGRectMake(100, 400, 200, 21)
        rangeDistanceLabel.text = "hey hey"
        beaconDistanceLabel = rangeDistanceLabel
        self.view.addSubview(beaconDistanceLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func convertProximityToString(proximity:CLProximity) ->String {
        switch proximity.toRaw() {
        case 0:
            return "Unknown"
        case 1:
            return "Immediate"
        case 2:
            return "Near"
        case 3:
            return "Far"
        default:
            return "Unknown"
        }
    }

    func discoveredBeacon(#major: String, minor: String, proximity: CLProximity) {
        //println("VC major:\(major) minor:\(minor) distance:\(proximity)")
        //let BEACON_GREEN_MAJOR = "544"
        //let BEACON_GREEN_MINOR = "50962"
        if ((major == BEACON_GREEN_MAJOR) && (minor == BEACON_GREEN_MINOR)) {
            println("we found the green beacon with distance:\(proximity.toRaw())")
            self.beaconDistanceLabel!.text = convertProximityToString(proximity)
        }
        if ((major == BEACON_PURPLE_MAJOR) && (minor == BEACON_PURPLE_MINOR)) {
            println("we found the green beacon with distance:\(proximity.toRaw())")
            self.beaconDistanceLabel!.text = convertProximityToString(proximity)
        }
        
    }

    func updatedRange(state: CLRegionState) {
        if (state == CLRegionState.Unknown) {
            self.regionStatusLabel!.text = "unknown"
        }
        else if (state == CLRegionState.Inside) {
            self.regionStatusLabel!.text = "inside"
        }
        else if (state == CLRegionState.Outside) {
            self.regionStatusLabel!.text = "outside"
        }
        else {
            println("cry")
        }

    }

    func scanButtonClicked(sender: UIButton!) {
        println("scanButtonClicked")

        // Change 1) color of button 2) enable/disable beacon manager
        if self.scanMode {
            self.scanButton!.backgroundColor = UIColor.redColor()
//            self.scanButton!.setImage(scanImgOff, forState: UIControlState.Normal)
            self.beaconManager!.stop()
            self.beaconManager!.delegate = nil
        } else {
            self.scanButton!.backgroundColor = UIColor.greenColor()
//            self.scanButton!.setImage(scanImgOn, forState: UIControlState.Normal)
            self.beaconManager!.start()
            self.beaconManager!.delegate = self
        }

        // Toggle scan mode
        self.scanMode = !self.scanMode
    }


}

