//
//  Buttons .swift
//  Sensors
//
//  Created by Tristan Giguère on 2021-11-18.
//

import SwiftUI

struct Dark_Circle_Arrow_Button: View {
    var body: some View {
            VStack {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15)
                    .foregroundColor(Color("Third"))
                    .frame(width: 35, height: 35)
                    .background(Color("Main"))
                    
                    
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color(.white).opacity(0.4), radius: 5, x: 15, y: 15)
                    .shadow(color: Color(.white).opacity(0.35), radius: 5, x: 0.0, y: 5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Main"))
            .edgesIgnoringSafeArea(.all)
    }
}

struct Buttons__Previews: PreviewProvider {
    static var previews: some View {
        Dark_Circle_Arrow_Button()
    }
}
