import Foundation

public enum Localize {
  public enum Error {
    public static let invalidRequestURL = Localize.localized("ErrorInvalidRequestURL")
    /// %d is unexpected status code
    public static func unexpectedStatusCode(_ p1: Int) -> String {
      return Localize.localized("ErrorUnexpectedStatusCode \(p1)")
    }
    /// An error has occurred
    public static let unknown = Localize.localized("ErrorUnknown")
  }
  public enum GitHubRepositoryDetail {
    /// Repository Detail
    public static let title = Localize.localized("GitHubRepositoryDetailTitle")
    public enum Button {
      /// Check in GitHub page
      public static let gitnubNavigation = Localize.localized("GitHubRepositoryDetailButtonGitHubNavigation")
    }
  }
  public enum GitHubRepositoryList {
    /// Search Repository
    public static let title = Localize.localized("GitHubRepositoryListTitle")
    public enum Search {
      /// Enter a keyword and search!
      public static let notDone = Localize.localized("GitHubRepositoryListSearchNotDone")
      /// No data
      public static let resultIsEmpty = Localize.localized("GitHubRepositoryListSearchResultIsEmpty")
    }
    public enum SearchBar {
      /// You can search for GitHub repositories
      public static let placeholder = Localize.localized("GitHubRepositoryListSearchBarPlaceholder")
    }
  }
}

extension Localize {
    private static func localized(_ key: String) -> String {
        let format = Bundle.module.localizedString(forKey: key, value: nil, table: "localizable")
        return String(format: format, locale: Locale.current, arguments: [])
    }
}
