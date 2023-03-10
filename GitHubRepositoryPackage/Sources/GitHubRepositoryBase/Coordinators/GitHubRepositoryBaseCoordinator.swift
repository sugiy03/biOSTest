//
//  GitHubRepositoryBaseCoordinator.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit
import Combine
import GitHubRepositoryCore
import GitHubRepositoryList
import GitHubRepositoryDetail

public final class GitHubRepositoryBaseCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController = UINavigationController(nibName: nil, bundle: nil)
    private let gitHubRepositoryListCoordinator: GitHubRepositoryListCoordinator
    private var gitHubRepositoryDetailCoordinator: GitHubRepositoryDetailCoordinator?
    private var cancellableSet = Set<AnyCancellable>()

    public init(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
        gitHubRepositoryListCoordinator = GitHubRepositoryListCoordinator(navigationController: navigationController)
    }

    public func start() {
        gitHubRepositoryListCoordinator.start()
        gitHubRepositoryListCoordinator.eventNotificationPublisher
            .sink { [weak self] event in
                switch event {
                case.didTapListItem(let model):
                    self?.navivateDetailPage(model: model)
                }
            }
            .store(in: &cancellableSet)
    }

    private func navivateDetailPage(model: GitHubRepositoryItemModel) {
        gitHubRepositoryDetailCoordinator = GitHubRepositoryDetailCoordinator(navigationController: navigationController, model: model)
        gitHubRepositoryDetailCoordinator?.start()
    }
}
