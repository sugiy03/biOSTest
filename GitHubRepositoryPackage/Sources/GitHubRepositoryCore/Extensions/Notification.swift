//
//  Notification.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/10.
//

import UIKit

public extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }

    var keyboardFrame: CGRect? {
        guard let userInfo = self.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
                return nil
        }
        return keyboardFrame
    }

    var keyBoardExpandDuration: TimeInterval? {
        guard let userInfo = self.userInfo,
            let keyBoardExpandDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return nil }
        return keyBoardExpandDuration
    }
}
