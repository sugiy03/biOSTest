//
//  GitHubRepositoryListCellView.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/10.
//

import SwiftUI
import GitHubRepositoryCore

struct GitHubRepositoryListCellView: View {
    static let cellHeight = CGFloat(40)
    static let cellKey = "GitHubRepositoryListCell"
    let model: GitHubRepositoryItemModel
    
    var body: some View {
        HStack(spacing: 8) {
            AsyncImageTypeView(imageType: model.owner.avatarImageType)
            Text(model.fullName)
                .font(.system(size: 16, weight: .semibold))
            Spacer()
        }
    }
}

struct GitHubRepositoryListCellView_Previews: PreviewProvider {
    static var previews: some View {
        GitHubRepositoryListCellView(model: .mock)
    }
}
