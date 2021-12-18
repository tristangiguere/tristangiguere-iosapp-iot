import SwiftUI

struct SensorCard: View {
    var currentTemp: Double = 19
    var currentHumidity: Double = 55
    var lastUpdated = "17:58"
    var sensorName = "Basement"
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 50){
                
                // Icons + Last Updated
                VStack (alignment: .leading, spacing: 12){
                    // Icons
                    HStack (spacing: 16){
                        // Temperature
                        HStack (alignment: .center, spacing: 5){
                            Image(systemName: "thermometer")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                                .foregroundColor(Color("Fourth"))
                            
                            Text("\(currentTemp) ºC".uppercased())
                                .font(.custom("Mont Blanc Regular", size: 16))
                                .tracking(-0.64)
                                .foregroundColor(Color("Fourth"))
                            
                        }
                        
                        // Humidity
                        HStack (alignment: .center, spacing: 5){
                            Image(systemName: "drop")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                                .foregroundColor(Color("Fourth"))
                            
                            Text("\(currentHumidity) %".uppercased())
                                .font(.custom("Mont Blanc Regular", size: 16))
                                .tracking(-0.64)
                                .foregroundColor(Color("Fourth"))
                        }
                        
                    }
                    
                    Text("Last Updated: \(lastUpdated)".uppercased())
                        .font(.custom("Mont Blanc SemiBold", size: 10))
                        .foregroundColor(Color("Fourth").opacity(0.5))
                    
                }
                
                //Spacer()
                
                Text(sensorName)
                    .font(.custom("Mont Blanc SemiBold", size: 30))
                    .tracking(-1.2)
                    .foregroundColor(Color("Third"))
                
            }
            Spacer()
            
        }
        .padding(22)
        .frame(maxWidth: .infinity)
        .background(Color(.black).opacity(0.4))
        .cornerRadius(10)
        .shadow(color: Color(.black).opacity(0.5), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
    }
}
