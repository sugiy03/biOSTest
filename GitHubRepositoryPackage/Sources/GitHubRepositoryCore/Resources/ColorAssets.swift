
import UIKit

public enum ColorAssets: String {
    case backgroundPrimary
    case buttonPrimary
    case starFill
    case textPrimary

    public var color: UIColor {
        let colorAssetName = rawValue.prefix(1).uppercased() + rawValue.dropFirst()
        return UIColor(named: colorAssetName, in: .module, compatibleWith: nil)!
    }
}
