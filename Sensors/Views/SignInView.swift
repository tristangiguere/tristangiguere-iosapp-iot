import SwiftUI
import UIKit

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var showUnameAlert: Bool = false
    @State var showPwdAlert: Bool = false
    @StateObject var loginVM: AuthViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.2440480343, blue: 0.4294277892, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (spacing: 12){
                
                Text("Sign In")
                    .font(.custom("Mont Blanc Bold", size: 45))
                    .tracking(-2)
                    .foregroundColor(Color("Third"))
                    .padding(.bottom, 20)
                    .padding(.top, -20)
                
                // My sensors section title
                HStack {
                    VStack (spacing: 3){
                        Text("Username".uppercased())
                            .font(.custom("Mont Blanc Regular", size: 14))
                            .tracking(-0.56)
                            .foregroundColor(Color("Fourth"))

                        Rectangle()
                            .frame(width: 78, height: 0.8)
                            .foregroundColor(Color("Fourth"))
                    }
                    
                    // Push content to left
                    Spacer()
                }

                TextField("username", text: $username)
                    .font(.custom("Mont Blanc Bold", size: 16))
                    .padding()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.white).opacity(0.9))
                    .cornerRadius(10)
                
                HStack {
                    VStack (spacing: 3){
                        Text("Password".uppercased())
                            .font(.custom("Mont Blanc Regular", size: 14))
                            .tracking(-0.56)
                            .foregroundColor(Color("Fourth"))

                        Rectangle()
                            .frame(width: 78, height: 0.8)
                            .foregroundColor(Color("Fourth"))
                    }
                    
                    // Push content to left
                    Spacer()
                }.padding(.top)
                
                SecureField("••••••••", text: $password)
                    .font(.custom("Mont Blanc Bold", size: 16))
                    .padding()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.white).opacity(0.9))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    if (username == "" || password == "") { showPwdAlert = true }
                    
                    else if (username == "" && password == "") { showPwdAlert = true }
                    
                    else { loginVM.generateToken(username: username, password: password) }
                }, label: {
                    
                    Text("Submit".uppercased())
                        .font(.custom("Mont Blanc SemiBold", size: 16))
                        .foregroundColor(Color(.white))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2)
                            )
                })
                
            }.alert(isPresented: $showPwdAlert) {
                Alert(
                    title: Text("Invalid Credentials"),
                    message: Text("Username or password cannot be empty"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            .padding(.horizontal, 30)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(loginVM: AuthViewModel())
    }
}
