//
//  ApiHandler.swift
//  Smartmob
//
//  Created by Amresh Subedi on 9/6/19.
//  Copyright © 2019 Amresh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class APIHandler: NSObject {
    
    static func getTopImages(viewController:UIViewController,  completion: @escaping (MainResponse?) -> Void){
        APIManager.init(urlString: AppURL.topTenImage, method: .get).handleResponse(showProgressHud: true, showBanner: false, completionHandler: { (responses: MainResponse) in
            completion(responses)
        }) {
            print("Error")
        }
    }
    
}
