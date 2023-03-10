//
//  AsyncImageTypeView.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/10.
//

import SwiftUI

public struct AsyncImageTypeView: View {
    private let imageType: ImageType
    private let contentMode: ContentMode

    public init(imageType: ImageType, contentMode: ContentMode = .fit) {
        self.imageType = imageType
        self.contentMode = contentMode
    }

    public var body: some View {
        switch imageType {
        case .imageURL(let URL):
            AsyncImage(url: URL) { image in
                image
                    .resizable()
                    .aspectRatio(1, contentMode: contentMode)
            } placeholder: {
                ProgressView()
            }
        case .uiImage(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(1, contentMode: contentMode)
        }
    }
}

struct AsyncImageTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageTypeView(imageType: .imageURL(URL: URL(string: "https://www.rbbtoday.com/article/2016/03/04/140287.html")!))
    }
}
