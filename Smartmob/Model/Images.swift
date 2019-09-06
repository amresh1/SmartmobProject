//
//  Images.swift
//
//  Created by Amresh Subedi on 9/6/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

 class Images: Mappable{

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
    required convenience public init?(map: Map) {
        self.init()
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
}
