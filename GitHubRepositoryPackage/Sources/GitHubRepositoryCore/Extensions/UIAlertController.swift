//
//  UIAlertController.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/10.
//

import UIKit

public extension UIAlertController {
     static func presentOKAlert(withTitle title: String = "", withMessage message: String, handler: (() -> Void)? = nil) {
        // Present alert in new window to allow for multiple presentations
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = .alert + 1
        alertWindow.makeKeyAndVisible()

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            .addAction(title: "OK", style: .default, handler: { _ in
                handler?()
                alertWindow.resignKey()
            })
        alertWindow.rootViewController?.present(alertController, animated: true)
    }

    func addAction(if condition: @autoclosure () -> Bool = true, title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        if condition() {
            let action = UIAlertAction(title: title, style: style, handler: handler)
            addAction(action)
        }
        return self
    }
}

