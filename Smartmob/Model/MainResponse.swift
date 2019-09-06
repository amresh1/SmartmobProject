//
//  MainResponse.swift
//
//  Created by Amresh Subedi on 9/6/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class MainResponse: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kMainResponseImagesKey: String = "images"

  // MARK: Properties
  public var images: [Images]?

  // MARK: ObjectMapper Initalizers
  /**
   Map a JSON object to this class using ObjectMapper
   - parameter map: A mapping from ObjectMapper
  */
  required public init?(_ map: Map){

  }

  /**
  Map a JSON object to this class using ObjectMapper
   - parameter map: A mapping from ObjectMapper
  */
  public func mapping(map: Map) {
    images <- map[kMainResponseImagesKey]
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = images { dictionary[kMainResponseImagesKey] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.images = aDecoder.decodeObject(forKey: kMainResponseImagesKey) as? [Images]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(images, forKey: kMainResponseImagesKey)
  }

}
