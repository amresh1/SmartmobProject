//
//  MainResponse.swift
//
//  Created by Amresh Subedi on 9/6/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class MainResponse: DefaultResponse {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private let kMainResponseImagesKey: String = "images"
    
    // MARK: Properties
    public var images: [Images]?
    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required convenience public init?(map: Map) {
        self.init()
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public override func mapping(map: Map) {
        super.mapping(map: map)
        images <- map[kMainResponseImagesKey]
    }
}
