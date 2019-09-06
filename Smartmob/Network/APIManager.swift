//
//  Smartmob
//
//  Created by Amresh Subedi on 9/6/19.
//  Copyright © 2019 Amresh. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SVProgressHUD

public class APIManager {
    var request: DataRequest!
    public init (urlString: String, parameters: [String: Any]? = nil, headers: [String: String] = [String: String](), method: Alamofire.HTTPMethod = .post, encoding: ParameterEncoding = URLEncoding.default) {
        var headers = headers, parameters = parameters
        
        debugPrint(headers, parameters, urlString)
        self.request = Alamofire.SessionManager.default.request(urlString, method: method, parameters: parameters ?? [:], encoding: encoding, headers: headers)
    }
    
    func handleResponse<T: DefaultResponse>(showProgressHud: Bool = true, showBanner: Bool = false, completionHandler: @escaping (T) -> Void, failureBlock: @escaping (() -> Void)) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard NetworkReachabilityManager()!.isReachable else {
            failureBlock()
            let alertController = UIAlertController (title: "No Internet Connection", message: "Please enable data / wifi from settting", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            appDelegate?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            failureBlock()
            return
        }
        if showProgressHud && SVProgressHUD.isVisible() == false {
            ProgressHud.showProgressHUD()
        }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 500 // seconds
        configuration.timeoutIntervalForResource = 500
        _ = Alamofire.SessionManager(configuration: configuration)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.request.responseObject {(response: DataResponse<T>) in
            ProgressHud.hideProgressHUD()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result {
            case .success(let dataX):
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                    completionHandler(dataX)
                } else {
                    SVProgressHUD.showError(withStatus: dataX.message ?? "Failure")
                }
            case .failure(let error):
                print(error)
            }
        }
        //delete
        self.request.responseJSON {(response) in
            print(response.result.value ?? "No Value")
            print(response.result )
            print(response.error ?? "")
            print(response.response ?? "")
            print(response.request ?? "No request")
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let val):
                print(val)
            }
        }
    }
}
class ProgressHud: NSObject {
    class func showProgressHUD() {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor (UIColor.white)
        SVProgressHUD.setBackgroundColor (UIColor.clear)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setRingNoTextRadius(20)
        SVProgressHUD.setRingThickness(3)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
    }
    class func hideProgressHUD() {
        SVProgressHUD.dismiss()
    }
}
