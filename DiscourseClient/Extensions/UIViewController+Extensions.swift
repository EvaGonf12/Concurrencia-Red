//
//  UIViewController+Extensions.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

// COLORS
let colorError = UIColor(named: "ColorError")
let colorSuccess = UIColor(named: "ColorSuccess")
let colorPrimary = UIColor(named: "ColorPurpleLight")
let colorButtons = UIColor(named: "ColorPurpleButtons")
let colorPurple = UIColor(named: "ColorPurple")
let colorBgLight = UIColor(named: "ColorBgWhite")
let colorPurpleText = UIColor(named: "ColorPurpleText")
let colorGrayText = UIColor(named: "ColorGrayText")
let colorPink = UIColor(named: "ColorPink")
let colorPurpleDark = UIColor(named: "ColorPurpleDark")

extension UIViewController {
    /// Muestra un alertcontroller con una única acción
    /// - Parameters:
    ///   - alertMessage: Mensaje del alert
    ///   - alertTitle: Título del alert
    ///   - alertActionTitle: Título de la acción
    ///   - alertAction: Acción a ejecutar
    func showAlert(_ alertMessage: String,
                   _ alertTitle: String?,
                   _ alertActionTitle: String?,
                   _ alertAction: (() -> Void)?) {

        let title = alertTitle ?? "ALERT"
        let actionTitle = alertActionTitle ?? "OK"
        
        let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alertController.view.tintColor = colorPrimary
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (_) in
            guard let alertAction = alertAction else {return}
            alertAction()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    /// Muestra un alertcontroller con una única acción
    /// - Parameters:
    ///   - alertMessage: Mensaje del alert
    ///   - alertTitle: Título del alert
    ///   - alertActionTitle: Título de la acción
    ///   - alertActionStyle: Estilo del botón del alert
    ///   - action: Acción a ejecutar
    func showActionAlert(msg alertMessage: String,
                         title alertTitle: String?,
                         actionTitle aTitle: String?,
                         actionStyle aStyle: UIAlertAction.Style,
                         action: (() -> Void)?) {
        let title = alertTitle ?? "ALERT"
        let aTitleText = aTitle ?? "OK"
        
        let alertController = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alertController.view.tintColor = colorPrimary
        alertController.addAction(UIAlertAction(title: aTitleText, style: aStyle, handler: { (_) in
            guard let aAction = action else {return}
            aAction()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
