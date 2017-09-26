//
//  FoursquareApi.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

enum ResponseStatus {
    case Error;
    case NoPlaces;
    case PlaceFound;
    case LastPlaceFound;
}

class FoursquareApi: NSObject {
    
    var requestID:String?
    var numberOfFoundPlaces = 0
    
    init(_ requestID:String) {
        super.init()
        self.requestID = requestID
    }

    func getPlacesForLocation(_ lang:Double,_ lat:Double, complition: @escaping (_ result: Place?,_ status:ResponseStatus,_ requestID:String) ->Void ) -> Void {
        
        // Load Api keys
        let clientID = getConfigurationValueOfApiForKey(Constants.CLIENT_ID)
        let clientSecret = getConfigurationValueOfApiForKey(Constants.CLIENT_SECRET)
        
        // Make request to get places
        let url = "\(Constants.BASE_URL)\(lang),\(lat)\(Constants.URL_CLIENT_ID)\(clientID)\(Constants.URL_CLIENT_SECRET)\(clientSecret)\(Constants.URL_RADIUS)\(Constants.DEFAULT_SEARCH_RADIUS)"
        
        print("URL:  " + url)
        
//        var places:[Place]? = [Place]()
        var place:Place?
        
        // Make request
        Alamofire.request(url).responseObject { (response: DataResponse<PlacesResponse>) in
            
            if let placesResponse = response.result.value {
            var venues:[Venue] = [Venue]()
            
            if placesResponse.meta?.code! == Constants.SUCCESS {
                
                // Gathering all venues
                for group in (placesResponse.response?.groups)! {
                    for item in group.items!{
                        venues.append(item.venue!)
                    }
                }
                
                // Found no places
                if venues.count == 0 {
                    complition(place, .NoPlaces, self.requestID!)
                }
                
                self.numberOfFoundPlaces = venues.count
                
                // Requesting images for each place
                venues.map({ (r)  in
                    
                    let imageUrl = "\(Constants.BASE_IMAGE_URL)\(r.id!)/photos?v=20131016\(Constants.URL_CLIENT_ID)\(clientID)\(Constants.URL_CLIENT_SECRET)\(clientSecret)"
                    Alamofire.request(imageUrl).responseObject { (response: DataResponse<ImageResponse>) in
                    
                        if let images = response.result.value {
                            if (images.response?.photos?.items?.count)! > 0{
                               let image = images.response?.photos?.items?[0]
                                r.imageUrl = "\((image?.prefix)!)\((image?.width)!)x\((image?.height)!)\((image?.suffix)!)"
                                print("Has Pic")
                            } else {
                                print("No Pic")
                            }
                        } else {
                            print("No Pic")
                        }
                     place = VenueToPlaceParser.parseVenueToPlace(r)
                        
                    // Found place
                    self.numberOfFoundPlaces -= 1
                        
                        if self.numberOfFoundPlaces == 0 {
                            complition(place, .LastPlaceFound, self.requestID!)
                        } else {
                            complition(place, .PlaceFound, self.requestID!)
                        }
                     
                    }
                })
                
            } else {
                // Error
                place = nil
                complition(place, .Error, self.requestID!)
            }
            
            } else {
                // Error
                place = nil
                complition(place, .Error, self.requestID!)
            }
        
            
        }
    }
    
    
    func getConfigurationValueOfApiForKey(_ key:String) -> String {
        let filePath = Bundle.main.path(forResource: "keys", ofType: "plist")
        
        // Put the keys in a dictionary
        let plist = NSDictionary(contentsOfFile: filePath!)
        
        // Pull the value for the key
        let value:String = plist?.object(forKey: key) as! String
        
        return value
    }
}
