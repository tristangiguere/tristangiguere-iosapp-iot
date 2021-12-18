import Foundation

// Authentication request object
struct AuthRequestObject: Codable {
    var username: String
    var password: String
}

// Object to store user token and expiry time.
struct SessionData: Codable {
    var expires_at: String
    var token: String
}

// Object that stores a record of data (temp or humidity here)
struct DataRecord: Codable, Identifiable, Hashable {
    var data: Double
    var data_type: String
    var date_time: String
    var id: Int
    var pi_id: Int
}
