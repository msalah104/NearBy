//
//  ImageResponse.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit
import ObjectMapper

class ImageResponse: Mappable {
    
    var response:ResponseImage?
    var meta:MetaImage?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
        meta <- map["meta"]
    }

}

 class MetaImage: Mappable{
    
    var code:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
    }
}

class ResponseImage: Mappable{
    
    var photos:Photos?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        photos <- map["photos"]
    }
}


class Photos: Mappable{
    var items:[ItemsImages]?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}

class ItemsImages: Mappable{
    var prefix:String?
    var suffix:String?
    var width:Int?
    var height:Int?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        prefix <- map["prefix"]
        suffix <- map["suffix"]
        width <- map["width"]
        height <- map["height"]
    }
}
