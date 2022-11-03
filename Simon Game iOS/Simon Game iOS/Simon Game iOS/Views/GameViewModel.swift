//
//  GameViewModel.swift
//  Simon Game iOS
//
//  Created by Nunzio Ricci on 03/11/22.
//

import SwiftUI

extension GameView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var points: Int = 0
        @Published var tile: [TileView.ViewModel] = [
            TileView.ViewModel(color: .red, sound: 1201),
            TileView.ViewModel(color: .blue, sound: 1200),
            TileView.ViewModel(color: .green, sound: 1202),
            TileView.ViewModel(color: .yellow, sound: 1203),
        ]
        
        var sequenceToRemember : [Int] = []
        var currentToInsert: Int = 0
        
        @Published var inRound = false
        
        init() {
            for i in 0..<4 {
                tile[i].onTap = {
                    self.selected(tile: i)
                }
            }
            tilesTappable(false)
        }
        
        
        func startRound() {
            currentToInsert = 0
            populate()
            playSequence()
        }
        
        func playSequence(sequence: [Int]? = nil) {
            Task {
                inRound = true
                for tileIndex in sequence ?? sequenceToRemember {
                    try await tile[tileIndex].tap()
                }
                tilesTappable(true)
            }
        }
        
        func selected(tile tileIndex: Int) {
            if tileIndex == sequenceToRemember[currentToInsert] {
                currentToInsert += 1
                checkWin()
            } else {
                lose()
            }
        }
        
        func checkWin() {
            if sequenceToRemember.count <= currentToInsert {
                win()
            }
        }
        
        func lose() {
            points = 0
            sequenceToRemember = []
            finishRound()
        }
        
        func win() {
            points += 1
            finishRound()
        }
        
        func finishRound() {
            inRound = false
            tilesTappable(false)
        }
        
        func populate(_ quantity: Int = 1) {
            for _ in 0..<quantity {
                sequenceToRemember.append(Int.random(in: 0..<4))
            }
        }
        
        func tilesTappable(_ tappable: Bool) {
            for t in tile {
                t.abled = tappable
            }
        }
    }
}
