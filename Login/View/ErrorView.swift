//
//  ErrorView.swift
//  Login
//
//  Created by Abhishek Kumar on 05/01/21.
//

import SwiftUI

struct ErrorView: View {
    @State var color = Color.black.opacity(0.7)
    @Binding var error : String
    @Binding var alert : Bool
    var body: some View {
        GeometryReader { _ in
            VStack {
                HStack {
                    Text("Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal , 25)
                
                Text(self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                Button {
                    self.alert.toggle()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 140)
                }
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top, 25)
                .padding(.bottom , 10)

            }
            .frame(width: UIScreen.main.bounds.width - 70, height: UIScreen.main.bounds.height / 3.5)
            .background(Color.white)
            .cornerRadius(15)
            .padding([.leading,.trailing] , 40)
            .padding(.top , UIScreen.main.bounds.height / 2.5)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
