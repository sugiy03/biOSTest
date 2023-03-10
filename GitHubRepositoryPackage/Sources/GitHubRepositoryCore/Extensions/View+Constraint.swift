//
//  View+Constraint.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/10.
//

import UIKit

public enum ViewConstraintType {
    case height(height: CGFloat)
    case width(width: CGFloat)
    case sameRatio(height: CGFloat)
    case sameWidth(view: UIView)
    case sameHeight(view: UIView)
    case multiplierWidth(view: UIView, multiplier: CGFloat)
    case multiplierHeight(view: UIView, multiplier: CGFloat)
    case noConstraint
}

public extension UIView {
    func addAutoSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }

    func constrainEdges(to parent: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        return [
            topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ]
    }

    func addConstraint(type: ViewConstraintType) {
        switch type {
        case .height(let height):
            heightAnchor.constraint(equalToConstant: height).isActive = true
        case .width(let width):
            widthAnchor.constraint(equalToConstant: width).isActive = true
        case .sameRatio(let height):
            heightAnchor.constraint(equalToConstant: height).isActive = true
            widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        case .sameWidth(view: let view):
            widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        case .sameHeight(view: let view):
            heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        case .multiplierWidth(view: let view, multiplier: let multiplier):
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
        case .multiplierHeight(view: let view, multiplier: let multiplier):
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
        case .noConstraint: break
        }
    }

    func addEdgeConstrainedSubView(_ view: UIView, insets: UIEdgeInsets = .zero) {
        addAutoSubview(view)
        NSLayoutConstraint.activate(view.constrainEdges(to: self, insets: insets))
    }

    func constrainSize(_ size: CGSize) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        return [
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ]
    }

    func constrainedBy(center: CGPoint, size: CGSize, in parent: UIView) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        return [
            centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: center.x),
            centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: center.y),
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ]
    }
}

