//
//  RefreshButton.swift
//  Sensors
//
//  Created by Tristan Giguère on 2021-12-08.
//

import SwiftUI

struct RefreshButton: View {
    var body: some View {
        Image(systemName: "arrow.clockwise")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 16)
            .foregroundColor(Color("Third"))
            .frame(width: 34, height: 34)
            .background(Color("Main"))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .shadow(color: Color(.white).opacity(0.10), radius: 12, x: 0.0, y: 1)
            .shadow(color: Color(.white).opacity(0.35), radius: 5, x: 0.0, y: 5)
    }
}
