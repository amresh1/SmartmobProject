//
//  DefaultResponse.swift
//  Amakomaya
//
//  Created by Amresh Subedi on 7/18/19.
//  Copyright © 2019 Aavishkar. All rights reserved.
//

import Foundation
import ObjectMapper
class DefaultResponse: NSObject, NSCoding, Mappable {
  var status: String?
  var message: String?
  required init?(coder aDecoder: NSCoder) {
  }
  override init() {
    super.init()
  }
  func encode(with aCoder: NSCoder) {
  }
  required init?(map: Map) {
  }
  func mapping(map: Map) {
    status <- map["status"]
    message <- map["error.message"]
  }
}
