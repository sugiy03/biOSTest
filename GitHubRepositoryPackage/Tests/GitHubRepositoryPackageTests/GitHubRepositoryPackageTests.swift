import XCTest
@testable import GitHubRepositoryCore
@testable import GitHubRepositoryList
@testable import GitHubRepositoryTestCore

final class GitHubRepositoryPackageTests: XCTestCase {
    func testGitHubRepositoryDecode() throws {
        // Bundle.moduleは、Pacakge.swiftのResourcesにファイルを登録しないと、エラーになる
        guard let url = GitHubRepositoryCore.bundleURL(fileName: "search_repositories_200_response", fileExtension: "json"),
              let data = try? Data(contentsOf: url)else {
            XCTFail("Can't load JSON file")
            return
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let gitHubRepositoryModel = try decoder.decode(GitHubRepositoryModel.self, from: data)
            let items = gitHubRepositoryModel.items
            XCTAssertEqual(items.count, 2)
            let model = items[0]
            XCTAssertEqual(model.fullName, "dtrupenn/Tetris")
            XCTAssertEqual(model.language, "Assembly")
            XCTAssertEqual(model.stargazersCount, 1000)
            XCTAssertEqual(model.watchersCount, 2)
            XCTAssertEqual(model.forksCount, 0)
            XCTAssertEqual(model.openIssuesCount, 3)
            XCTAssertEqual(
                model.owner.avatarImageType.URL?.absoluteString,
                "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
            )
            XCTAssertEqual(model.owner.htmlUrl.absoluteString, "https://github.com/octocat")

            let model2 = items[1]
            XCTAssertEqual(model2.language, nil)
        } catch {
            XCTFail("Failed to encode json to model \(error.localizedDescription)")
        }
    }

    func testSearchResultErrorResponse() async throws {
        await XCTContext.runActivityAsync(named: "statusCode is 304") { _ in
            do {
                try ErrorHandler.handleHttpError(statusCode: 304)
                XCTFail("This test case is for error")
            } catch {
                XCTAssertEqual(error.asCustomError, .responseError(error: .notModified))
            }
        }

        await XCTContext.runActivityAsync(named: "statusCode is 403") { _ in
            do {
                try ErrorHandler.handleHttpError(statusCode: 403)
                XCTFail("This test case is for error")
            } catch {
                XCTAssertEqual(error.asCustomError, .responseError(error: .forbidden))
            }
        }

        await XCTContext.runActivityAsync(named: "statusCode is 422") { _ in
            do {
                try ErrorHandler.handleHttpError(statusCode: 422)
                XCTFail("This test case is for error")
            } catch {
                XCTAssertEqual(error.asCustomError, .responseError(error: .validationFailedOrEndpointSpammed))
            }
        }

        await XCTContext.runActivityAsync(named: "statusCode is 503") { _ in
            do {
                try ErrorHandler.handleHttpError(statusCode: 503)
                XCTFail("This test case is for error")
            } catch {
                XCTAssertEqual(error.asCustomError, .responseError(error: .serviceUnavailable))
            }
        }
    }
}
