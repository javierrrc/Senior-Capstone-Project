//
//  TLButton.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/29.
//

import SwiftUI

struct TLButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button (action: {
            //Attempt to log in
            action()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .bold()
                    .foregroundColor(Color.white)
            }
            
        })
        .padding()
    }
}

#Preview {
    TLButton(title: "Value", background: .blue) {
        //Action
    }
}
