//
//  InternetAlert.swift
//  SportsApp
//
//  Created by Rafeef Esam on 11/05/2023.
//

import Foundation
import UIKit
extension UIViewController {
    func showNoInternetAlert() {
        let alert = UIAlertController(title: nil, message: "No internet connection please check your wi-fi or moblie data and try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
