//
//  GitHubRepositoryListCoordinator.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit
import Combine
import GitHubRepositoryCore

public enum GitHubRepositoryListEvent {
    case didTapListItem(model: GitHubRepositoryItemModel)
}

public final class GitHubRepositoryListCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let gitHubRepositoryListViewController = GitHubRepositoryListViewController.instatiate()
    private let eventNotificationSubject = PassthroughSubject<GitHubRepositoryListEvent, Never>()
    public var eventNotificationPublisher: AnyPublisher<GitHubRepositoryListEvent, Never> {
        return eventNotificationSubject.eraseToAnyPublisher()
    }
    private var cancellableSet = Set<AnyCancellable>()

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        Logger.debugDeinit()
    }

    public func start() {
        navigationController.setViewControllers([gitHubRepositoryListViewController], animated: false)
        gitHubRepositoryListViewController.eventNotificationPublisher
            .sink { [weak self] event in
                guard let self else { return }
                self.eventNotificationSubject.send(event)
            }
            .store(in: &cancellableSet)
    }
}
