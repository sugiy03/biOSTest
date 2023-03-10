//
//  RepresentableWrapper.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit
import SwiftUI

public struct UIViewControllerPreviewWrapper: UIViewControllerRepresentable {
    public let previewController: UIViewController

    public init(previewController: UIViewController) {
        self.previewController = previewController
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        return previewController
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

public struct UIViewPreviewWrapper: UIViewRepresentable {
    public let previewView: UIView

    public init(previewView: UIView) {
        self.previewView = previewView
    }

    public func makeUIView(context: Context) -> some UIView {
        return previewView
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {}
}
