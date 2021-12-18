import Foundation
import CryptoSwift


// On Launch: read user defaults and set token in app
// If Expiration is > now -> set login state to

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    // Get auth token and store into user defaults
    func generateToken(username: String, password: String) {
        let url = URL(string: "http://dmitryg.pythonanywhere.com/token")
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let authRequestData = AuthRequestObject(username: username, password: (password.sha256()))

        let jsonData = try! JSONEncoder().encode(authRequestData)

        request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let error = error {
                    print("Error took place: \(error)")
                    return
                }
                guard let data = data else {return}
                
                do {
                    let sessionData = try JSONDecoder().decode(SessionData.self, from: data)
                    let expiryDate = self.getTokenExpiry()
                    UserDefaults.standard.set(sessionData.token, forKey: "authToken")
                    UserDefaults.standard.set(expiryDate, forKey: "expiration")
                    print("Stored info to UserDefaults.")
                    DispatchQueue.main.async { self.isLoggedIn = true }
                    UserDefaults.standard.set(true, forKey: "is_authenticated")
                } catch let jsonErr{
                    print(jsonErr)
               }
        }
        task.resume()
    }
    
    func checkLogin(){
        
        let expiryDate = UserDefaults.standard.object(forKey: "expiration")
        let currentDate = NSDate.now
        let is_authenticated = UserDefaults.standard.bool(forKey: "is_authenticated")
        
        if (is_authenticated) {
            if  let expiryDate = UserDefaults.standard.object(forKey: "expiration") {
                if ((expiryDate as! Date) < currentDate) {
                    print("Token expired")
                    isLoggedIn = false
                    UserDefaults.standard.set("", forKey: "authToken")
                    UserDefaults.standard.set(false, forKey: "is_authenticated")
                }
            }
            
            else if  let expiryDate = UserDefaults.standard.object(forKey: "expiration") {
                if ((expiryDate as! Date) > currentDate) {
                    print("Not expired yet")
                    if UserDefaults.standard.object(forKey: "authToken") != nil {
                        isLoggedIn = true
                        
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    }
                }
            }
        }
        
        else {
            print("Not Valid")
            isLoggedIn = false
            UserDefaults.standard.set("", forKey: "authToken")
        }
    }
    
    // Log user out and remove the token from UserDefaults for security purposes.
    func signOut(){
            UserDefaults.standard.set("", forKey: "authToken")
            isLoggedIn = false
    }
    
    // Get the token expiry date when generating
    
    func getTokenExpiry() -> Date {
        // Add 3 hours to the current date
        let expDate = NSDate.now.addingTimeInterval(10800)
        return expDate
    }
}
