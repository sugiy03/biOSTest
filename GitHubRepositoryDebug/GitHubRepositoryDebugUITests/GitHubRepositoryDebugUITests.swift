//
//  GitHubRepositoryDebugUITests.swift
//  GitHubRepositoryDebugUITests
//
//  Created by yugo.sugiyama on 2023/03/07.
//

import XCTest
@testable import GitHubRepositoryTestCore
@testable import GitHubRepositoryCore
@testable import GitHubRepositoryList
@testable import GitHubRepositoryDetail

final class GitHubRepositoryDebugUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testListAndDetailUI() throws {
        let app = XCUIApplication()
        app.launchArguments = [
            ProcessArgumentsKind.uiTest.rawValue,
            ProcessArgumentsKind.stubSuccess.rawValue,
        ]
        app.launch()
        XCTAssertTrue(app.tables[GitHubRepositoryListTestIdentifier.tableView.rawValue].exists)

        let listScreenshot = app.windows.firstMatch.screenshot()
        let listAttachment = XCTAttachment(screenshot: listScreenshot)
        listAttachment.lifetime = .keepAlways
        add(listAttachment)

        if (app.tables[GitHubRepositoryListTestIdentifier.tableView.rawValue].cells.count > 0) {
            XCTAssertTrue(app.tables[GitHubRepositoryListTestIdentifier.tableView.rawValue].cells.count == 2)
            app.tables[GitHubRepositoryListTestIdentifier.tableView.rawValue].cells.element(boundBy: 0).tap()
            XCTAssertTrue(app.images[GitHubRepositoryDetailTestIdentifier.avatarImageView.rawValue].exists)
            XCTAssertTrue(app.staticTexts[GitHubRepositoryDetailTestIdentifier.titleLabel.rawValue].exists)
            XCTAssertEqual(app.staticTexts[GitHubRepositoryDetailTestIdentifier.titleLabel.rawValue].label, "dtrupenn/Tetris")

            XCTAssertTrue(app.staticTexts[GitHubRepositoryDetailTestIdentifier.languageLabel.rawValue].exists)
            XCTAssertEqual(app.staticTexts[GitHubRepositoryDetailTestIdentifier.languageLabel.rawValue].label, "Written in Assembly")
            XCTAssertTrue(app.staticTexts[GitHubRepositoryDetailTestIdentifier.starsCountLabel.rawValue].exists)
            XCTAssertEqual(app.staticTexts[GitHubRepositoryDetailTestIdentifier.starsCountLabel.rawValue].label, "1,000")
            XCTAssertTrue(app.staticTexts[GitHubRepositoryDetailTestIdentifier.watchersCountLabel.rawValue].exists)
            XCTAssertEqual(app.staticTexts[GitHubRepositoryDetailTestIdentifier.watchersCountLabel.rawValue].label, "2 watchers")
            XCTAssertTrue(app.staticTexts[GitHubRepositoryDetailTestIdentifier.forksCountLabel.rawValue].exists)
            XCTAssertEqual(app.staticTexts[GitHubRepositoryDetailTestIdentifier.forksCountLabel.rawValue].label, "0 forks")
            XCTAssertTrue(app.staticTexts[GitHubRepositoryDetailTestIdentifier.issuesCountLabel.rawValue].exists)
            XCTAssertEqual(app.staticTexts[GitHubRepositoryDetailTestIdentifier.issuesCountLabel.rawValue].label, "3 open issues")
            XCTAssertTrue(app.buttons[GitHubRepositoryDetailTestIdentifier.safariNavigationButton.rawValue].exists)
            XCTAssertEqual(app.buttons[GitHubRepositoryDetailTestIdentifier.safariNavigationButton.rawValue].label, "Check in GitHub page")
            XCTAssertTrue(app.buttons[GitHubRepositoryDetailTestIdentifier.safariNavigationBottomButton.rawValue].exists)

            let detailScreenshot = app.windows.firstMatch.screenshot()
            let detailAttachment = XCTAttachment(screenshot: detailScreenshot)
            detailAttachment.lifetime = .keepAlways
            add(detailAttachment)
        } else  {
            XCTFail("TableView must not be empty")
        }
    }
}
