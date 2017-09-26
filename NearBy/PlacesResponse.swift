//
//  PlacesResponse.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit
import ObjectMapper

class PlacesResponse: Mappable {
    
    var response:Response?
    var meta:Meta?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        meta <- map["meta"]
    }

}

class Meta: Mappable{
    
    var code:Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
    }
}

class Response: Mappable{
    
    var groups:[Groups]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
       groups <- map["groups"]
    }
}

class Groups: Mappable{
    var items:[Items]?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}

class Items: Mappable{
    var venue:Venue?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        venue <- map["venue"]
    }
}

class Venue: Mappable{
    var id:String?
    var name:String?
    var imageUrl:String?
    var location:Location?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        location <- map["location"]
    }
}

class Location: Mappable{
    
    var formattedAddress:[String]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
       formattedAddress <- map["formattedAddress"]
        
        
    }
}
