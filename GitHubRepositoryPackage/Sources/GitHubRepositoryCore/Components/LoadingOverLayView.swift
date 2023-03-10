//
//  LoadingOverLayView.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit

final class LoadingOverLayView: UIView {
    private var indicatorView: UIActivityIndicatorView

    init(indicatorStyle: UIActivityIndicatorView.Style) {
        indicatorView = UIActivityIndicatorView(style: indicatorStyle)
        super.init(frame: .zero)

        addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.topAnchor.constraint(equalTo: topAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: indicatorView.trailingAnchor),
            bottomAnchor.constraint(equalTo: indicatorView.bottomAnchor)
        ])
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {
        indicatorView.startAnimating()
    }

    func stopAnimation() {
        indicatorView.stopAnimating()
    }
}
