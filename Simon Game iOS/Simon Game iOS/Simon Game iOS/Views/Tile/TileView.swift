//
//  Tile.swift
//  Simon Game iOS
//
//  Created by Bruno De Vivo on 28/10/22.
//

import SwiftUI

struct TileView: View {
    @ObservedObject var model: ViewModel
    
    init(_ model: ViewModel) {
        self.model = model
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 100.0, height: 100.0)
                .cornerRadius(20.0)
                .foregroundColor(model.color)
            
            Rectangle()
                .frame(width: 80.0, height: 80.0)
                .cornerRadius(20.0)
                .foregroundColor(model.brighting ? .white : model.color)
                .shadow(radius: 50.0)
                .blur(radius: 2.5)
        } .onTapGesture {
            model.onTap?()
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(TileView.ViewModel(color: .red, sound: 1201))
    }
}
