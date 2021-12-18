import SwiftUI

struct SensorDetail: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var tempVM: TempViewModel
    @State var selectedPeriodIndex = 0
    @State var sensorName: String = ""
    @State var chartData = [0.24, 0.32, 0.21, 0.60, 0.4, 0.9, 0.3]
    @State var lastUpdated: String = ""
    @State var temperature: Double
    @State var hum: Double
    @State var lastDayTemp: [DataRecord]
    @State var last7dTemp: [DataRecord]
    @State var last30dTemp: [DataRecord]
    @State var lastDayHum: [DataRecord]
    @State var last7dHum: [DataRecord]
    @State var last30dHum: [DataRecord]
    
    var body: some View {
        ZStack {
            // Background color
            Color("Main").edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center, spacing: 5){
                
                HStack{
                    Spacer()
                    RefreshButton()
                        .onTapGesture {
                            tempVM.getAllData()
                        }
                }.padding(.trailing, 30)
                .padding(.top, -15)
                
                Text(sensorName)
                    .font(.custom("Mont Blanc SemiBold", size: 30))
                    .tracking(-1.2)
                    .foregroundColor(Color("Third"))
                
                Text("Last Updated: \(lastUpdated)".uppercased())
                    .font(.custom("Mont Blanc SemiBold", size: 10))
                    .foregroundColor(Color("Fourth").opacity(0.5))
                    .padding(.bottom, 20)

                ScrollView(showsIndicators: false) {
                    
                    VStack (spacing: 30) {
                        CurrentData(temperature: temperature, humi: hum)
                    
                        Picker("Period", selection: $selectedPeriodIndex) {
                                        Text("Last 24H").tag(0)
                                        Text("Week").tag(1)
                                        Text("Month").tag(2)
                                    }.pickerStyle(SegmentedPickerStyle())
                        
                        VStack (spacing: 20){
                            
                            TitleUnderlined(title: "History", lineWidth: 58)

                        }
                        .background(Color(.black).opacity(0.4))
                        .cornerRadius(10)
                        .shadow(color: Color(.black).opacity(0.5), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)

                        
                        // Table starts here
                        VStack (spacing: 20){
                            
                            TitleUnderlined(title: "Recent Data", lineWidth: 90)
                            
                            VStack{
                                //Table header
                                TableHeader()
                                
                                Divider()
                                
                                if (selectedPeriodIndex == 0) {
                                    ForEach(lastDayTemp.indices, id: \.self) { index in
                                    RowList(dateTime: lastDayTemp[index].date_time, temp: lastDayTemp[index].data, hum: lastDayHum[index].data)
                                    Divider()
                                }
                                }
                                
                                if (selectedPeriodIndex == 1) {
                                    ForEach(last7dTemp.indices, id: \.self) { index in
                                    RowList(dateTime: last7dTemp[index].date_time, temp: last7dTemp[index].data, hum: last7dHum[index].data)
                                    Divider()
                                }
                                }
                                
                                if (selectedPeriodIndex == 2) {
                                    ForEach(last30dTemp.indices, id: \.self) { index in
                                        RowList(dateTime: last30dTemp[index].date_time, temp: last30dTemp[index].data, hum: last30dHum[index].data)
                                    Divider()
                                }
                                }
                            }
                           // .onAppear(perform: tempVM.getAllData())
                            .animation(.spring())
                        }
                        .frame(maxWidth: .infinity)
                        .padding(30)
                        .background(Color(.black).opacity(0.4))
                        .cornerRadius(10)
                        .shadow(color: Color(.black).opacity(0.5), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5)

                    }.padding(.top, 0)
                    .padding(.horizontal, 30)
                }
                Spacer()
            }

            .frame(maxWidth: .infinity)
//            .padding(.top, -30)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            HStack {
                Image(systemName: "arrow.left").foregroundColor(.white.opacity(0.7))
                Text("My Sensors").font(.custom("Mont Blanc SemiBold", size: 15)).foregroundColor(.white.opacity(0.7))
            }
        })
    }
}

struct SensorDetail_Previews: PreviewProvider {
    static var previews: some View {
        SensorDetail(tempVM: TempViewModel(), temperature: 0, hum: 0, lastDayTemp: [DataRecord](), last7dTemp: [DataRecord](), last30dTemp: [DataRecord](), lastDayHum: [DataRecord](), last7dHum: [DataRecord](), last30dHum: [DataRecord]())
    }
}
