//
//  HeaderView.swift
//  Fitnext
//
//  Created by Connor Marry on 5/30/24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let rotation: Double
    let background: Color
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: rotation))
                
            VStack{
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .bold()
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .padding(.top, 80)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)
    }
}

#Preview {
    HeaderView(title: "Title",
               subtitle: "Subtitle",
               rotation: 15,
               background: .blue)
}
