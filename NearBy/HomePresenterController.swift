//
//  HomePresenterController.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/21/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit


enum PlacesUpdateType:String {
    case Realtime = "Realtime";
    case SingleTime = "SingleTime";
}


// Protocol to all state for the home view
protocol HomeViewDelegate: NSObjectProtocol {
    
    // Loading
    func startLoading()
    func finishLoading()
    
    // Error
    func someThingWrongHappend()
    func noNearPlaces()
    func locationError()
    
    // UpdateData
    func updatePlaces(_ places:[Place])
    func readyToReciveData()
    func requestFinished()
    // TODO will be updated
    func insertPlace(_ place:Place)
}

class HomePresenterController: NSObject {
    
    let CACH_FILE_NAME = "cached.plist"
    
    weak fileprivate var homeView:HomeViewDelegate?
    fileprivate var locationUpdater:LocationUpdater?
    fileprivate var placesUpdateType:PlacesUpdateType?
    fileprivate var reachability:Reachability!
    fileprivate var foursquareApi:FoursquareApi?
    var lastRequestID:String?
    
    // MARK:- view methods
    
    func attachView(_ view:HomeViewDelegate)  {
        self.homeView = view
        self.placesUpdateType = NearByUserDefaults.getCurrentUpdateMode()
        startReachabilityNotifier()
        
        // Make first request on app starts
        startUpdating()
    }
    
    func detachView(_ view:HomeViewDelegate)  {
        self.homeView = nil
        reachability.stopNotifier()
    }
    
    func setPlacesUpdateType(_ type:PlacesUpdateType){
        self.placesUpdateType = type
        NearByUserDefaults.setCurrentUpdateMode(type)
        
        startUpdating()
    }

    func getPlacesUpdateType() -> PlacesUpdateType {
        return NearByUserDefaults.getCurrentUpdateMode()
    }
    
    func getCachedPlaces() -> [Place] {
        return NearByUserDefaults.getCachedPlaces()
    }
    
    func cachCurrentRequest(_ places:[Place]) {
        
        NearByUserDefaults.setCachedPlaces(places)
    }
    
    // MARK:- Reachability
    
    func startReachabilityNotifier()
    {
        NotificationCenter.default.addObserver(self, selector:Selector(("checkForReachability:")), name: NSNotification.Name.reachabilityChanged, object: nil)
        let reachability: Reachability = Reachability.forInternetConnection()
        reachability.startNotifier()
    }
    
    func checkForReachability(notification:NSNotification)
    {
        let networkReachability = notification.object as! Reachability;
        let remoteHostStatus = networkReachability.currentReachabilityStatus()
        
        
        if (remoteHostStatus == NotReachable)
        {
            print("Not Reachable")
        }
        else
        {
            print("Reachable")
        }
    }

    
    
    // MARK:- Private methods
    
    func startUpdating() {
        
        self.homeView?.startLoading()
        
        if locationUpdater != nil {
            locationUpdater?.stopUpdating()
        }
        
        locationUpdater = LocationUpdater()
        
        if placesUpdateType == .Realtime {
            locationUpdater?.updateMeWhenLocationChange(self)
        } else {
            locationUpdater?.getMeCurrentLocation(self)
        }
    }
    
    fileprivate func getPlacesForLoaction(_ long:Double, _ lat:Double){
        
        // Start calling Foursquare api
        foursquareApi = nil
        
        lastRequestID = String(Date().timeIntervalSince1970)
        foursquareApi = FoursquareApi(lastRequestID!)
        
        foursquareApi?.getPlacesForLocation(long, lat) { (place, status, requestID) in
            
            if self.lastRequestID! == requestID {
                
                self.homeView?.finishLoading()
                
                if status == ResponseStatus.Error {
                    self.homeView?.someThingWrongHappend()
                } else if status == ResponseStatus.NoPlaces {
                    self.homeView?.noNearPlaces()
                } else if status == ResponseStatus.LastPlaceFound {
                    self.homeView?.insertPlace(place!)
                    self.homeView?.requestFinished()
                } else {
                    self.homeView?.insertPlace(place!)
                }
            }
            
        }
        
        
    }
    
    
}

extension HomePresenterController:LocationDelegate {
    
    func userNewCurrentLocation(_ long:Double, _ lat:Double) {
        
        getPlacesForLoaction(long, lat)
        self.homeView?.readyToReciveData()
    }
    
    func errorWhileRequestLocation(_ error: Error) {
        self.homeView?.locationError()
    }

}
