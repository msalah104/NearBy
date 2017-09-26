//
//  VenueToPlaceParser.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit

class VenueToPlaceParser: NSObject {

    class func parseVenueToPlace(_ venue:Venue) -> Place{
        
        let place = Place()
        place.id = venue.id
        place.name = venue.name
        place.imageUrl = venue.imageUrl
        
        if (venue.location?.formattedAddress?.count)! > 0 {
            place.address1 = venue.location?.formattedAddress?[0]
        }
        
        if (venue.location?.formattedAddress?.count)! > 1 {
            place.address2 = venue.location?.formattedAddress?[1]
        }
        
        if (venue.location?.formattedAddress?.count)! > 2 {
            place.address3 = venue.location?.formattedAddress?[2]
        }
        
        if (venue.location?.formattedAddress?.count)! > 3 {
            place.address4 = venue.location?.formattedAddress?[3]
        }
        
        return place
    }
    
    
    class func parseVenuesToPlaces(_ venues:[Venue]) -> [Place]{
        var places:[Place] = [Place]()
        
        for venue in venues {
            places.append(parseVenueToPlace(venue))
        }
        
        return places
    }
    
}
