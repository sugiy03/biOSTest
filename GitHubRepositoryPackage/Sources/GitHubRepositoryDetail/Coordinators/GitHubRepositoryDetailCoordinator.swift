//
//  GitHubRepositoryDetailCoordinator.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit
import Combine
import GitHubRepositoryCore
import SafariServices

public enum GitHubRepositoryDetailEvent {
    case didTapRepositoryWebPageButton(url: URL)
}

public final class GitHubRepositoryDetailCoordinator: Coordinator {
    let gitHubRepositoryDetailViewController: GitHubRepositoryDetailViewController
    let navigationController: UINavigationController
    private var cancellableSet = Set<AnyCancellable>()

    public init(navigationController: UINavigationController, model: GitHubRepositoryItemModel) {
        self.navigationController = navigationController
        gitHubRepositoryDetailViewController = GitHubRepositoryDetailViewController.instatiate(model: model)
    }

    deinit {
        Logger.debugDeinit()
    }

    public func start() {
        navigationController.pushViewController(gitHubRepositoryDetailViewController, animated: true)
        gitHubRepositoryDetailViewController.eventNotificationPublisher
            .sink { [weak self] event in
                self?.handleEvents(event: event)
            }
            .store(in: &cancellableSet)
    }

    private func handleEvents(event: GitHubRepositoryDetailEvent) {
        switch event {
        case .didTapRepositoryWebPageButton(let url):
            let safariViewController = SFSafariViewController(url: url)
            gitHubRepositoryDetailViewController.present(safariViewController, animated: true)
        }
    }
}
