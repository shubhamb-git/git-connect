//
//  Alert.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import UIKit

extension UIAlertController {

   class func present(withTitle title: String? = "Alert!!", description: String? = nil) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        UIApplication.shared.windows.last?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    class func internetError(retry: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            // Hide Porgress
            let alertController = UIAlertController.init(title: "Connection Failed!", message: GCConstants.inernetConnectionErrorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Retry", style: .default) {
                UIAlertAction in
                //Show progress
                retry?()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            alertController.addAction(cancelAction)
            if retry != nil {
                alertController.addAction(okAction)
            }
            UIApplication.shared.windows.last?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

