//
//  UIView.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit

public extension UIView {
    func presentErrorAlert(error: GitHubRepositoryCustomError) {
        UIAlertController.presentOKAlert(withMessage: error.localizedDescription)
    }
}
