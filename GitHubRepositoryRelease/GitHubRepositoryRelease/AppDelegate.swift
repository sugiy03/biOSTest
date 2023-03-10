//
//  AppDelegate.swift
//  GitHubRepositoryRelease
//
//  Created by yugo.sugiyama on 2023/03/05.
//

import UIKit
import GitHubRepositoryBase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var gitHubRepositoryBaseCoordinator: GitHubRepositoryBaseCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return true }

        gitHubRepositoryBaseCoordinator = GitHubRepositoryBaseCoordinator(window: window)
        gitHubRepositoryBaseCoordinator?.start()

        return true
    }
}
