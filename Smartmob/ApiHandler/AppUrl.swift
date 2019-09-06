//
//  AppUrl.swift
//  Smartmob
//
//  Created by Amresh Subedi on 9/6/19.
//  Copyright © 2019 Amresh. All rights reserved.
//

import Foundation
import Foundation
class AppURL: NSObject {
    static let baseUrl = "http://www.splashbase.co/"
    
    static var topTenImage: String = {
        let url = baseUrl + "api/v1/images/latest"
        return url
    }()
}
