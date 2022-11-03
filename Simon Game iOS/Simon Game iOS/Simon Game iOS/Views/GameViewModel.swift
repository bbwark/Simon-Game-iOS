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
        @Published var sequenceToRemember : [Int] = []
        @Published var sequenceToInsert : [Int] = []
        
        @Published var insertedValue : Int = -1
        
        @Published var touchable = false
        
        @Published var listening = false
        
        @Published var playing = false
        
        
        init() {
            for i in 0..<4 {
                tile[i].onTap = {
                    self.sequenceToInsert.append(i)
                }
            }
        }
        
        
        func startRound() -> Void {
            playing = true
            sequenceToRemember.append(Int.random(in: 1...4))
            print("play")
            playSequence(sequence: sequenceToRemember)
            sequenceToInsert.removeAll()
            listening = true
            print("\(sequenceToRemember)")
            print("listening")
        }
        
        func playSequence(sequence: [Int]) -> Void {
            touchable = false
            Task {
                for num in sequence {
                    await tile[num].tap()
                }
                touchable = true
            }
            //continue the execution of the program after the sequence completed to run
            while !touchable {}
        }
        
        func checkNextRound() {
            if(listening){
                
                //check if the last element inserted in position N is the same in position N of the corresponding sequence: if it is not, then it resets both sequences, resets the points, sets listening false; if it is then check if the sequences are of the same length: if they are then add a period, set listening to false, call the next round
                
                let lastInsertedIndex : Int = sequenceToInsert.count - 1
                
                print("\(lastInsertedIndex): inserted \(sequenceToInsert[lastInsertedIndex])/\(sequenceToRemember[lastInsertedIndex]) to remember")
                
                if(sequenceToInsert[lastInsertedIndex] == sequenceToRemember[lastInsertedIndex]){
                    print("SAME")
                    if(sequenceToInsert.count == sequenceToRemember.count){
                        print("ENTERELY SAME")
                        points += 1
                        listening = false
                        touchable = false
                        startRound()
                    }
                }
                else{
                    print("NOT SAME")
                    points = 0
                    listening = false
                    sequenceToInsert.removeAll()
                    sequenceToRemember.removeAll()
                    playing = false
                    touchable = false
                }
            }
        }
    }
}
