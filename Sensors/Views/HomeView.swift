// App Homepage

import SwiftUI

struct HomeView: View {
    @StateObject var tempVM: TempViewModel
    @StateObject var authVM: AuthViewModel
    var body: some View {
        // Main Page Layout
        NavigationView {
            ZStack {
                
                // App Background Color
                Color("Main")
                    .ignoresSafeArea()
                
                VStack (spacing: 15){
                    
                    // Top Heading Title section
                    HStack (alignment: .center){
                        Text("Home")
                            .font(.custom("Mont Blanc Bold", size: 50))
                            .tracking(-2)
                            .foregroundColor(Color("Third"))
                        Spacer()
                        RefreshButton()
                            .onTapGesture {
                                tempVM.getAllData()
                            }
                    }
                    .padding(.top)
                    
                    // My sensors section title
                    HStack {
                        VStack (spacing: 3){
                            Text("My Sensors".uppercased())
                                .font(.custom("Mont Blanc Regular", size: 14))
                                .tracking(-0.56)
                                .foregroundColor(Color("Fourth"))
                            
                            Rectangle()
                                .frame(width: 87, height: 0.8)
                                .foregroundColor(Color("Fourth"))
                        }
                        
                        // Push content to left
                        Spacer()
                    }
                    
                    
                    // Sensor Cards
                    NavigationLink(
                        
                        destination: SensorDetail(tempVM: tempVM, sensorName: "Garage", lastUpdated: tempVM.lastUpdated, temperature: tempVM.sensor1_last_temp, hum: tempVM.sensor1_last_humidity, lastDayTemp:tempVM.sensor1_lastDay_temp, last7dTemp: tempVM.sensor1_last7Days_temp, last30dTemp: tempVM.sensor1_lastMonth_temp, lastDayHum: tempVM.sensor1_lastDay_humidity, last7dHum: tempVM.sensor1_last7Days_hum, last30dHum: tempVM.sensor1_lastMonth_hum),
                        label: {

                            SensorCard(currentTemp: tempVM.sensor1_last_temp, currentHumidity: tempVM.sensor1_last_humidity, lastUpdated: tempVM.lastUpdated, sensorName: "Garage")
                            
                        })
                    NavigationLink(
                        
                        destination: SensorDetail(tempVM: tempVM, sensorName: "Living Room", lastUpdated: tempVM.lastUpdated, temperature: tempVM.sensor2_last_temp, hum: tempVM.sensor2_last_humidity, lastDayTemp: tempVM.sensor2_lastDay_temp, last7dTemp: tempVM.sensor2_last7Days_temp, last30dTemp: tempVM.sensor2_lastMonth_temp, lastDayHum: tempVM.sensor2_lastDay_humidity ,last7dHum: tempVM.sensor2_last7Days_hum, last30dHum: tempVM.sensor2_lastMonth_hum),
                        label: {
                            
                            SensorCard(currentTemp: tempVM.sensor2_last_temp, currentHumidity: tempVM.sensor2_last_humidity, lastUpdated: tempVM.lastUpdated, sensorName: "Living Room")
                        })
                    Spacer()
                    Button(action: {
                        if authVM.isLoggedIn{
                            authVM.signOut()
                        }
                        else{
                            return
                        }
                        
                    }, label: {
                        Text(authVM.isLoggedIn ? "Sign Out" : "You are not logged in.")
                            .font(.custom("Mont Blanc Regular", size: 15))
                            .foregroundColor(Color("Third"))
                    })
                    
                }
//                .onAppear(perform: {
//                    tempVM.getAllData()
//                })
                .frame(maxWidth: .infinity ,maxHeight: .infinity)
                .padding(.horizontal, 30)
                
            }
            .animation(.spring())
            .navigationTitle("Home")
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tempVM: TempViewModel(), authVM: AuthViewModel())
    }
}
