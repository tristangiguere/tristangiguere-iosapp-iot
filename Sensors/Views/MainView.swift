import SwiftUI

struct MainView: View {
    @StateObject var authVM: AuthViewModel
    @StateObject var tempVM: TempViewModel = TempViewModel()
    var body: some View {
        ZStack{
            
            
            if(authVM.isLoggedIn){
                HomeView(tempVM: tempVM, authVM: authVM).onAppear(perform: {tempVM.getAllData()})
                
            }
            
            // Show login view if user is not logged in.

            SignInView(loginVM: authVM)
                .offset(x: 0, y: authVM.isLoggedIn ? 1000 : 0 )
                .animation(.spring())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authVM: AuthViewModel())
    }
}
