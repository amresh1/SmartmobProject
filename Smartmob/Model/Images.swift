//
//  Images.swift
//
//  Created by Amresh Subedi on 9/6/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class Images: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kImagesLargeUrlKey: String = "large_url"
  private let kImagesInternalIdentifierKey: String = "id"
  private let kImagesUrlKey: String = "url"

  // MARK: Properties
  public var largeUrl: String?
  public var internalIdentifier: Int?
  public var url: String?

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
    largeUrl <- map[kImagesLargeUrlKey]
    internalIdentifier <- map[kImagesInternalIdentifierKey]
    url <- map[kImagesUrlKey]
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = largeUrl { dictionary[kImagesLargeUrlKey] = value }
    if let value = internalIdentifier { dictionary[kImagesInternalIdentifierKey] = value }
    if let value = url { dictionary[kImagesUrlKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.largeUrl = aDecoder.decodeObject(forKey: kImagesLargeUrlKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kImagesInternalIdentifierKey) as? Int
    self.url = aDecoder.decodeObject(forKey: kImagesUrlKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(largeUrl, forKey: kImagesLargeUrlKey)
    aCoder.encode(internalIdentifier, forKey: kImagesInternalIdentifierKey)
    aCoder.encode(url, forKey: kImagesUrlKey)
  }

}
