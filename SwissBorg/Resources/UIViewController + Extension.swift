//
//  UIViewController + Extension.swift
//  SwissBorg
//
//  Created by Eduard Stern on 08.06.2022.
//

import UIKit

extension  UIViewController {
    // create and show UIAlertController
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            self?.dismiss(animated: true)
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
