//
//  StartButtonView.swift
//  Simon Game iOS
//
//  Created by Bruno De Vivo on 04/11/22.
//

import SwiftUI

struct StartButtonView: View {
    
    @State var shine = false
    
    var body: some View {
        
        
        let frame = Rectangle()
            .frame(width: 140.0, height: 50.0)
            .cornerRadius(15.0)
        
        ZStack {
            frame.foregroundColor(.white)
            ZStack{
                ZStack {
                    frame.foregroundColor(.blue)
                    Text("Start")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Rectangle()
                    .frame(width: 40.0, height: 50.0)
                    .offset(x: shine ? -105 : 105)
                    .opacity(0.2)
                    .foregroundColor(.white)
                    .blur(radius: 8.0)
                    .blendMode(.destinationOut)
            }.compositingGroup()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: false)){
                shine.toggle()
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            StartButtonView()
        }
    }
}
