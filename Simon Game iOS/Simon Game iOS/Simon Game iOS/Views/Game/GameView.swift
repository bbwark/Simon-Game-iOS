//
//  GameView.swift
//
//  Created by Bruno De Vivo on 28/10/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var model: ViewModel = ViewModel()
    
    var body: some View {
        ZStack {
            
            VStack{
                Text("\(model.points)")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Sequence Playing")
                    .foregroundColor(model.isPlaying ? .blue : .clear)
                    .animation(.linear(duration: 0.07))
                
                HStack{
                    TileView(model.tile[0])
                    TileView(model.tile[1])
                }
                
                HStack{
                    TileView(model.tile[2])
                    TileView(model.tile[3])
                }
                
                Spacer()
            }
            
            if !model.inGame {
                VStack {
                    Spacer()
                    Button {
                        model.startRound()
                    } label: {
                        StartButtonView()
                    }
                    .disabled(model.inGame)
                    .offset(y: -80.0)
                }
                .transition(.move(edge: .bottom))
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


