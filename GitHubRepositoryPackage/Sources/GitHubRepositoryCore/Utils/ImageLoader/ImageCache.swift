//
//  ImageCache.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/11.
//

import UIKit

final class ImageCache: NSCache<NSString, UIImage> {
    static let shared = ImageCache()
    private override init() {}
}
