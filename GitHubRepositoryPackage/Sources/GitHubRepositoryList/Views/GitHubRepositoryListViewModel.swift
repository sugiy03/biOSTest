//
//  GitHubRepositoryListViewModel.swift
//  
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import Foundation
import Combine
import GitHubRepositoryCore

@MainActor
final class GitHubRepositoryListViewModel: ObservableObject {
    @Published private(set) var repositoryList: [GitHubRepositoryItemModel] = []
    @Published private(set) var error: Error?
    @Published private(set) var isLoading = false
    @Published private(set) var emptyListTextType: EmptyListTextType? = .searchNotDone
    @Published var searchAction: SearchActionType?
    @Published var incrementalSearchAction: SearchActionType?
    @Inject private var apiClient: APIProtocol
    private var cancellableSet = Set<AnyCancellable>()
    deinit {
        Logger.debugDeinit()

    }

    func setUpObservers() {
        $searchAction
            .merge(with: $incrementalSearchAction)
            .unwrap()
            .filter({ $0.keywords.allSatisfy({ !$0.isEmpty }) })
            .removeDuplicates(by: { element1, element2 in
                element1.keywords == element2.keywords
            })
            .sink { [weak self] searchActionType in
                guard let self else { return }
                Task {
                    await self.searchRepositories(searchActionType: searchActionType)
                }
            }
            .store(in: &cancellableSet)
    }

    private func searchRepositories(searchActionType: SearchActionType) async {
        let keywordQuery = searchActionType.keywords.joined(separator: " ")
        Logger.debugLog(message: "\(keywordQuery)", logCategory: .action)
        emptyListTextType = nil
        isLoading = searchActionType.shouldShowLoading
        do {
            let result = try await fetchRepositories(keywordQuery: keywordQuery)
            repositoryList = result.items
            emptyListTextType = result.items.isEmpty ? .resultIsEmpty : nil
        } catch {
            self.error = error
        }
        isLoading = false
    }

    private func fetchRepositories(keywordQuery: String) async throws -> GitHubRepositoryModel {
        guard let requestURL = URL(string: Constants.requestQueryURLString(query: keywordQuery)) else {
            throw GitHubRepositoryCustomError.invalidRequestURL
        }
        Logger.debugLog(message: requestURL.absoluteString, logCategory: .network)
        return try await apiClient.sendRequest(requestURL: requestURL)
    }
}
