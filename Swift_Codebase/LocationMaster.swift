//
//  LocationMaster.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/8/31.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import Foundation
import Contacts

class LocationMaster: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationMaster()
    
    var geoCoder: CLGeocoder?
    var locationManager: CLLocationManager?
    
    var currentLocation: CLLocation?
    
    var locationUpdated: ((location: CLLocation?) -> Void)?
    
    override init() {
        super.init()
        
        if geoCoder == nil {
            self.geoCoder = CLGeocoder()
        }
        
        if locationManager == nil {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.startUpdatingLocation()
        }
    }
    
    func lazy() {
        // DO NOTHING, JUST LET LocationMaster.init()
    }
    
    func getMylocation() -> CLLocation? {
        return self.currentLocation
    }
    
    // LOCATION MANAGER DELEGATES
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
        
        if let _locationUpdated = self.locationUpdated {
            _locationUpdated(location: self.currentLocation)
        }
    }
    
    // MARK: REVERSE GEOCODE
    func reverseGeocode(location: CLLocation, completion: (locationObject: LocationObject?) -> Void) {
        if self.geoCoder != nil {
            self.geoCoder?.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if error != nil {
                    Logger.me().error("\(error)")
                    completion(locationObject: nil)
                } else {
                    if placemarks?.count != 0 {
                        let placemark = placemarks?.last
                        //                        return ABCreateStringWithAddressDictionary(placemark!.addressDictionary!, false)
                        if placemark != nil {
                            let address = self.localizedStringForAddressDictionary(placemark!.addressDictionary!)
                            let locObject = LocationObject(coordinate: placemark!.location!.coordinate, address: address)
                            completion(locationObject: locObject)
                        }
                    } else {
                        Logger.me().error("Reverse geocoding for \(location) failed.")
                        completion(locationObject: nil)
                    }
                }
            })
        }
    }
    
    func reverseGeocodeMyLocation(completion: (locationObject: LocationObject?) -> Void) {
        guard self.currentLocation != nil else {
            Logger.me().debug("My location doesn't exist.")
            return
        }
        
        reverseGeocode(self.currentLocation!, completion: completion)
    }
    
    // Convert to the newer CNPostalAddress
    private func postalAddressFromAddressDictionary(addressdictionary: Dictionary<NSObject,AnyObject>) -> CNMutablePostalAddress {
        
        let address = CNMutablePostalAddress()
        
        address.street = addressdictionary["Street"] as? String ?? ""
        address.state = addressdictionary["State"] as? String ?? ""
        address.city = addressdictionary["City"] as? String ?? ""
        address.country = addressdictionary["Country"] as? String ?? ""
        address.postalCode = addressdictionary["ZIP"] as? String ?? ""
        
        return address
    }
    
    // Create a localized address string from an Address Dictionary
    private func localizedStringForAddressDictionary(addressDictionary: Dictionary<NSObject,AnyObject>) -> String {
        
        return CNPostalAddressFormatter.stringFromPostalAddress(postalAddressFromAddressDictionary(addressDictionary), style: .MailingAddress)
    }
    
    // MARK: GEOCODE
    func geoCode(address: String, completion: (locationObject: LocationObject?) -> Void) {
        guard self.geoCoder != nil else {
            completion(locationObject: nil)
            return
        }
        
        self.geoCoder?.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                completion(locationObject: nil)
            } else {
                let placemark = placemarks?.last
                
                guard placemark != nil else {
                    completion(locationObject: nil)
                    return
                }
                
                let locObject = LocationObject(coordinate: placemark!.location!.coordinate, address: address)
                completion(locationObject: locObject)
            }
        })
    }
}




