import Foundation

public struct Authorization: Codable {
    public var accessToken: String
    public var refreshToken: String
    public var expires: TimeInterval

    public init(accessToken: String, refreshToken: String, expires: TimeInterval) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expires = expires
    }
}
