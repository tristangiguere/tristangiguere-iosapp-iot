//
//  TableHEader.swift
//  Sensors
//
//  Created by Tristan Giguère on 2021-12-17.
//

import SwiftUI

struct TableHeader: View {
    var body: some View {
        HStack {
            Text("Time")
                .font(.custom("Mont Blanc SemiBold", size: 14))
                .tracking(-0.56)
                .foregroundColor(Color("Fourth"))
            
            Spacer()
            
            HStack {
                Text("Temp")
                    .font(.custom("Mont Blanc SemiBold", size: 14))
                    .tracking(-0.56)
                    .foregroundColor(Color("Fourth"))
                Text("|")
                    .font(.custom("Mont Blanc SemiBold", size: 14))
                    .tracking(-0.56)
                    .foregroundColor(Color("Fourth"))
                Text("Humidity")
                    .font(.custom("Mont Blanc SemiBold", size: 14))
                    .tracking(-0.56)
                    .foregroundColor(Color("Fourth"))
            }
        }
    }
}

struct CurrentData: View {
    @State var temperature: Double
    @State var humi: Double
    var body: some View {
        VStack (spacing: 20){
            
            VStack (spacing: 3){
                Text("Current Data".uppercased())
                    .font(.custom("Mont Blanc Regular", size: 14))
                    .tracking(-0.56)
                    .foregroundColor(Color("Fourth"))
                
                Rectangle()
                    .frame(width: 100, height: 0.8)
                    .foregroundColor(Color("Fourth"))
            }
            
            
            HStack(spacing: 25){
                HStack (spacing: 10){
                    Image(systemName: "thermometer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(Color("Third"))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    Text("\(temperature) ºC".uppercased())
                        .font(.custom("Mont Blanc Regular", size: 25))
                        .tracking(-0.64)
                        .foregroundColor(Color("Fourth"))
                }
                
                HStack (spacing: 10){
                    Image(systemName: "aqi.medium")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(Color("Third"))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    Text("\(humi) %".uppercased())
                        .font(.custom("Mont Blanc Regular", size: 25))
                        .tracking(-0.64)
                        .foregroundColor(Color("Fourth"))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .background(Color(.black).opacity(0.4))
        .cornerRadius(10)
        .shadow(color: Color(.black).opacity(0.5), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)
    }
}





struct TableHeader_Previews: PreviewProvider {
    static var previews: some View {
        TableHeader()
    }
}
