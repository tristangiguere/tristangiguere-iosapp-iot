import SwiftUI

@main
struct SensorsApp: App {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    
    init(){
        authVM.checkLogin()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(authVM: authVM)
        }
    }
}
