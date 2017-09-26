//
//  LocationManager.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit
import CoreLocation

enum LocationUpdateType {
    case CurrentLocation;
    case LocationUpdate
}

protocol LocationDelegate:NSObjectProtocol {
    // For monotoring user location change
    func userNewCurrentLocation(_ long:Double, _ lat:Double)
    func errorWhileRequestLocation(_ error: Error)
}

class LocationUpdater: NSObject, CLLocationManagerDelegate {
    
    // The distance you want to get notification when user exceed it, default is 500 meter
    fileprivate var filterDistance = Constants.DEFAULT_UPDATE_DISTANCE
    
    fileprivate var locationManager:CLLocationManager?
    fileprivate var updateType:LocationUpdateType?
    weak fileprivate var locationDelegate:LocationDelegate?
    fileprivate var previousLocation:CLLocation?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var location:CLLocation?
        
        if locations.count > 0 {
            location = locations[0]
        } else {
            return
        }
        
        // To avoid sending same location
        if previousLocation == nil {
            previousLocation = location
        } else if (previousLocation?.coordinate.latitude == location?.coordinate.latitude) &&
            (previousLocation?.coordinate.longitude == location?.coordinate.longitude){
            return
        } else {
            previousLocation = location
        }
        
        // Stop location manager if we just need to get current location
        if self.updateType == .CurrentLocation {
            self.locationManager?.delegate = nil
            self.locationManager?.stopUpdatingLocation()
        }
        
        self.locationDelegate?.userNewCurrentLocation(location!.coordinate.longitude, location!.coordinate.latitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationDelegate?.errorWhileRequestLocation(error)
    }

    
    func updateMeWhenLocationChange(_ me:LocationDelegate) {
        self.updateType = .LocationUpdate
        self.locationDelegate = me
        self.startLocationManager()
    }
    
    func getMeCurrentLocation(_ me:LocationDelegate) {
        self.updateType = .CurrentLocation
        self.locationDelegate = me
        self.startLocationManager()
    }
    
    fileprivate func startLocationManager(){
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.distanceFilter = self.filterDistance
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdating()  {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func setUpdateDistnace(_ distance:Double){
        self.filterDistance = distance
    }
}
