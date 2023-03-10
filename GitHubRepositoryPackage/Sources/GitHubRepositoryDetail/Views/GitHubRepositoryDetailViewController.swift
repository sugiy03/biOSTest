//
//  GitHubRepositoryDetailViewController.swift
//  GitHubRepository
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit
import SwiftUI
import Combine
import GitHubRepositoryCore

final class GitHubRepositoryDetailViewController: UIViewController {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var languageLabel: UILabel! {
        didSet {
            languageLabel.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var starsCountLabel: UILabel! {
        didSet {
            starsCountLabel.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var watchersCountLabel: UILabel! {
        didSet {
            watchersCountLabel.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var forksCountLabel: UILabel! {
        didSet {
            forksCountLabel.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var issuesCountLabel: UILabel! {
        didSet {
            issuesCountLabel.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var safariNavigationButton: UIButton! {
        didSet {
            safariNavigationButton.setTitle(Localize.GitHubRepositoryDetail.Button.gitnubNavigation, for: .normal)
            safariNavigationButton.backgroundColor = ColorAssets.buttonPrimary.color
            safariNavigationButton.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet private weak var safariNavigationBottomButton: UIButton! {
        didSet {
            safariNavigationBottomButton.backgroundColor = ColorAssets.buttonPrimary.color
        }
    }

    private let viewModel: GitHubRepositoryDetailViewModel
    private let eventNotificationSubject = PassthroughSubject<GitHubRepositoryDetailEvent, Never>()
    var eventNotificationPublisher: AnyPublisher<GitHubRepositoryDetailEvent, Never> {
        return eventNotificationSubject.eraseToAnyPublisher()
    }

    required init?(coder: NSCoder, model: GitHubRepositoryItemModel) {
        viewModel = GitHubRepositoryDetailViewModel(model: model)
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        Logger.debugDeinit()
    }

    static func instatiate(model: GitHubRepositoryItemModel) -> GitHubRepositoryDetailViewController {
        let storyboard = UIStoryboard(name: "GitHubRepositoryDetailBoard", bundle: .module)
        return storyboard.instantiateViewController(identifier: "GitHubRepositoryDetailViewController") { coder in
            GitHubRepositoryDetailViewController(coder: coder, model: model)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorAssets.backgroundPrimary.color
        title = Localize.GitHubRepositoryDetail.title

        setData(model: viewModel.model)

        safariNavigationButton.addAction(.init(handler: { [weak self] _ in
            guard let self else { return }
            self.eventNotificationSubject.send(.didTapRepositoryWebPageButton(url: self.viewModel.model.owner.htmlUrl))
        }), for: .touchUpInside)
    }

    private func setData(model: GitHubRepositoryItemModel) {
        if let language = model.language {
            languageLabel.text = "Written in \(language)"
        } else {
            languageLabel.text = "Language not set"
        }
        starsCountLabel.text = "\(model.stargazersCount.withComma)"
        watchersCountLabel.text = "\(model.watchersCount.withComma) watchers"
        forksCountLabel.text = "\(model.forksCount.withComma) forks"
        issuesCountLabel.text = "\(model.openIssuesCount.withComma) open issues"
        getImage(model: model)
    }

    private func getImage(model: GitHubRepositoryItemModel) {

        titleLabel.text = model.fullName

        let avatarImageType = model.owner.avatarImageType
        avatarImageView.setImageType(imageType: avatarImageType)
    }
}
