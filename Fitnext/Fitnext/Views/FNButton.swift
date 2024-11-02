//
//  FNButton.swift
//  Fitnext
//
//  Created by Connor Marry on 5/30/24.
//

import SwiftUI

struct FNButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    FNButton(title: "title", background: .blue) {
        //Action
    }
}
