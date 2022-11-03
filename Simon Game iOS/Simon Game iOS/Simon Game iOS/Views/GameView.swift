//
//  GameView.swift
//
//  Created by Bruno De Vivo on 28/10/22.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    @ObservedObject var model: ViewModel = ViewModel()
    
    var body: some View {
        VStack{
            Text("\(model.points)")
                .font(.largeTitle)
            
            Spacer()
            
            HStack{
                TileView(model.tile[0])
                TileView(model.tile[1])
            }
            
            HStack{
                TileView(model.tile[2])
                TileView(model.tile[3])
            }
            
            Spacer()
            
            Button {
                print("Start")
                model.startRound()
            } label: {
                Text("Start")
            }
                .disabled(model.inRound)
                .offset(y: -80.0)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


