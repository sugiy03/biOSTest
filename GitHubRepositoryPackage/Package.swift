// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitHubRepositoryPackage",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "GitHubRepositoryCore", targets: ["GitHubRepositoryCore"]),
        .library(name: "GitHubRepositoryList", targets: ["GitHubRepositoryList"]),
        .library(name: "GitHubRepositoryDetail", targets: ["GitHubRepositoryDetail"]),
        .library(name: "GitHubRepositoryBase", targets: ["GitHubRepositoryBase"]),
        .library(name: "GitHubRepositoryTestCore", targets: ["GitHubRepositoryTestCore"]),
    ],
    targets: [
        .target(
            name: "GitHubRepositoryCore",
            resources: [
                .process("Resources/JsonFiles/search_repositories_200_response.json"),
                // TODO: ディレクトリのコピーをできるようにする
//                 .copy("Resources")
            ]
        ),
        .target(
            name: "GitHubRepositoryList",
            dependencies: [
                "GitHubRepositoryCore",
            ]
        ),
        .target(
            name: "GitHubRepositoryDetail",
            dependencies: [
                "GitHubRepositoryCore",
            ]
        ),
        .target(
            name: "GitHubRepositoryBase",
            dependencies: [
                "GitHubRepositoryCore",
                "GitHubRepositoryList",
                "GitHubRepositoryDetail",
            ]
        ),
        .target(
            name: "GitHubRepositoryTestCore",
            dependencies: [
                "GitHubRepositoryCore",
                "GitHubRepositoryList",
                "GitHubRepositoryDetail",
            ]
        ),
        .testTarget(
            name: "GitHubRepositoryPackageTests",
            dependencies: [
                "GitHubRepositoryTestCore",
                "GitHubRepositoryCore",
                "GitHubRepositoryList",
            ]
        )
    ]
)
