import SwiftUI

struct RowList: View {
    
    @State var dateTime = ""
    @State var temp: Double  = 22
    @State var hum: Double = 0
    var body: some View {
        HStack{
            Text(dateTime)
                .font(.custom("Mont Blanc Regular", size: 14))
                .foregroundColor(Color(.white))
                .frame(maxWidth: 150)
            Spacer()
            
            HStack {
                Text("\(String(format: "%.2f", temp)) ºC")
                    .font(.custom("Mont Blanc Regular", size: 14))
                    .foregroundColor(Color(.white))
                
                Text("\(String(format: "%.2f", hum))%")
                    .font(.custom("Mont Blanc Regular", size: 14))
                    .foregroundColor(Color(.white))
            }
            
        }.padding(.vertical, 2)
    }
}
