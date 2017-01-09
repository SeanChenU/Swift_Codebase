//
//  LocationPickerViewController.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2017/1/9.
//  Copyright © 2017年 IgnioLab. All rights reserved.
//

import UIKit

class LocationPickerViewController: UIViewController, GMSMapViewDelegate {
    
    static let LocationPickerDoneNotificationName = "location.picker.done"
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addressLabel: UITextView!
    
    var currenLocObject: LocationObject?
    var pickerDone: (locObject: LocationObject?) -> Void = { locObject in }
    
    class func showLocationPicker(fromVC: UIViewController, pickerDone: (locObject: LocationObject?) -> Void ) -> LocationPickerViewController {
        let locationPicker = LocationPickerViewController(nibName: "LocationPickerViewController", bundle: nil)
        locationPicker.pickerDone = pickerDone
        fromVC.presentViewController(locationPicker, animated: true) { 
            
        }
        return locationPicker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUIs()
    }
    
    func setupUIs() {
        setupMap()
        self.addressLabel.layer.cornerRadius = 10.0
        self.addressLabel.layer.masksToBounds = true
        self.addressLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        self.addressLabel.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.2).CGColor
        self.addressLabel.layer.shadowRadius = 3.0
        
        self.cancelButton.addTapHandler { 
            self.dismissNow()
        }
        
        self.doneButton.addTapHandler { 
            NSNotificationCenter.defaultCenter().postNotificationName(LocationPickerViewController.LocationPickerDoneNotificationName, object: self.currenLocObject)
            
            self.pickerDone(locObject: self.currenLocObject)
            
            self.dismissNow()
        }
    }
    
    // MAP
    var flag_mapAnimated: Bool = false
    
    func setupMap() {
        self.mapView.myLocationEnabled = true
        self.mapView.delegate = self
        
        LocationMaster.sharedInstance.locationUpdated = { location in
            if !self.flag_mapAnimated {
                self.mapView.animateToCameraPosition(GMSCameraPosition.cameraWithTarget(location!.coordinate, zoom: 14))
                self.flag_mapAnimated = true
            } else {
            
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        let loc = CLLocation(latitude: position.target.latitude, longitude: position.target.longitude)
        LocationMaster.sharedInstance.reverseGeocode(loc) { (locationObject) in
            if let _locationObject = locationObject {
                print(_locationObject.address)
                self.addressLabel.text = _locationObject.address
                
                self.currenLocObject = locationObject
            }
        }
    }
    
    func mapView(mapView: GMSMapView, willMove gesture: Bool) {
        self.addressLabel.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
