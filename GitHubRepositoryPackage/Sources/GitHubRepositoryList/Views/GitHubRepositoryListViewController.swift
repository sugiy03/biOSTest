//
//  GitHubRepositoryListViewController.swift
//  GitHubRepository
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit
import SwiftUI
import Combine
import GitHubRepositoryCore

final class GitHubRepositoryListViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = Localize.GitHubRepositoryList.SearchBar.placeholder
            searchBar.delegate = self
            searchBar.searchTextField.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var repositoryListTableView: UITableView! {
        didSet {
            repositoryListTableView.delegate = self
            repositoryListTableView.dataSource = self
            repositoryListTableView.rowHeight = GitHubRepositoryListCellView.cellHeight
            repositoryListTableView.tableFooterView = UIView()
            repositoryListTableView.backgroundColor = ColorAssets.backgroundPrimary.color
            repositoryListTableView.register(UITableViewCell.self, forCellReuseIdentifier: GitHubRepositoryListCellView.cellKey)
        }
    }
    @IBOutlet private weak var emptyListTextLabel: UILabel! {
        didSet {
            emptyListTextLabel.textColor = ColorAssets.textPrimary.color
        }
    }
    @IBOutlet private weak var keyboardBackgroundViewHeightConstraint: NSLayoutConstraint!

    private let viewModel = GitHubRepositoryListViewModel()
    private let eventNotificationSubject = PassthroughSubject<GitHubRepositoryListEvent, Never>()
    private var cancellableSet = Set<AnyCancellable>()
    var eventNotificationPublisher: AnyPublisher<GitHubRepositoryListEvent, Never> {
        return eventNotificationSubject.eraseToAnyPublisher()
    }

    private init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        Logger.debugDeinit()
    }

    static func instatiate() -> GitHubRepositoryListViewController {
        Dependencies.root.add(module: .init {
            let apiClient: APIProtocol
            if ProcessInfo.processInfo.isUITest {
                apiClient = APIMock()
            } else {
                apiClient = APIClient()
            }
            return apiClient
        })
        Dependencies.root.build()
        let storyboard = UIStoryboard(name: "GitHubRepositoryListBoard", bundle: .module)
        return storyboard.instantiateViewController(identifier: "GitHubRepositoryListViewController") as? GitHubRepositoryListViewController ?? GitHubRepositoryListViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localize.GitHubRepositoryList.title
        setUpObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setUpObservers()
    }

    private func setUpObservers() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map(\.keyboardHeight)
            .sink { [weak self] keyboardHeight in
                let safeAreaBottomInsets = UIApplication.shared.windowScene?.keyWindow?.safeAreaInsets.bottom ?? 0
                self?.keyboardBackgroundViewHeightConstraint.constant = keyboardHeight - safeAreaBottomInsets
            }
            .store(in: &cancellableSet)
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                self?.keyboardBackgroundViewHeightConstraint.constant = 0
            }
            .store(in: &cancellableSet)
        setupViewModelObservers()
    }

    private func setupViewModelObservers() {
        viewModel.$emptyListTextType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                guard let self else { return }
                if let type {
                    self.emptyListTextLabel.text = type.text
                }
                self.emptyListTextLabel.isHidden = type == nil
            }
            .store(in: &cancellableSet)
        viewModel.$repositoryList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.repositoryListTableView.reloadData()
            }
            .store(in: &cancellableSet)
        viewModel.$isLoading
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                self.view.switchLoading(willLoading: isLoading)
            }
            .store(in: &cancellableSet)
        viewModel.$error.unwrap()
            .sink { [weak self] error in
                guard let self else { return }
                self.view.presentErrorAlert(error: error.asCustomError)
            }
            .store(in: &cancellableSet)
    }
}

extension GitHubRepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryItem = viewModel.repositoryList[indexPath.row]
        eventNotificationSubject.send(.didTapListItem(model: repositoryItem))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GitHubRepositoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GitHubRepositoryListCellView.cellKey,
            for: indexPath
        )
        let repoItem = viewModel.repositoryList[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration {
            GitHubRepositoryListCellView(model: repoItem)
        }
        .margins(.all, 0)
        return cell
    }
}

extension GitHubRepositoryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let word = searchBar.text else { return true }
        viewModel.incrementalSearchAction = .incrementalSearch(keywords: [word])
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(false)
        guard let word = searchBar.text else { return }
        viewModel.searchAction = .enterSearch(keywords: [word])
    }
}
