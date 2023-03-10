//
//  UIView+Loading.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit

public extension UIView {
    private static let loadingAnimationDuration: TimeInterval = 0.2
    func switchLoading(willLoading: Bool, indicatorStyle: UIActivityIndicatorView.Style = .medium) {
        if willLoading {
            showLoading(indicatorStyle: indicatorStyle)
        } else {
            hideLoading()
        }
    }

    func showLoading(indicatorStyle: UIActivityIndicatorView.Style = .large) {
        guard subviews.allSatisfy({ !($0 is LoadingOverLayView) }) else { return }
        isUserInteractionEnabled = false
        let overLayView = LoadingOverLayView(indicatorStyle: indicatorStyle)
        overLayView.alpha = 0
        addSubview(overLayView)
        overLayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overLayView.topAnchor.constraint(equalTo: topAnchor),
            overLayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: overLayView.trailingAnchor),
            bottomAnchor.constraint(equalTo: overLayView.bottomAnchor)
        ])
        UIView.animate(withDuration: UIView.loadingAnimationDuration, animations: {
            overLayView.alpha = 1
        }, completion: { _ in
            overLayView.startAnimation()
        })
    }

    func hideLoading() {
        isUserInteractionEnabled = true
        guard let overLayView = subviews
            .first(where: { $0 is LoadingOverLayView }) as? LoadingOverLayView else { return }
        UIView.animate(withDuration: UIView.loadingAnimationDuration, animations: {
            overLayView.alpha = 0
        }, completion: { _ in
            overLayView.stopAnimation()
            overLayView.removeFromSuperview()
        })
    }
}
