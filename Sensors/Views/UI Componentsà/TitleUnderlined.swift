//
//  TitleUnderlined.swift
//  Sensors
//
//  Created by Tristan Giguère on 2021-12-17.
//

import SwiftUI

struct TitleUnderlined: View {
    var title = ""
    var lineWidth: CGFloat = 0
    var body: some View {
        VStack (spacing: 3){
            Text(title.uppercased())
                .font(.custom("Mont Blanc Regular", size: 14))
                .tracking(-0.56)
                .foregroundColor(Color("Fourth"))

            Rectangle()
                .frame(width: lineWidth, height: 0.8)
                .foregroundColor(Color("Fourth"))
        }.padding(30)
    }
}

struct TitleUnderlined_Previews: PreviewProvider {
    static var previews: some View {
        TitleUnderlined()
    }
}
