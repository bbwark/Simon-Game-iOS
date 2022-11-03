//
//  TileViewModel.swift
//  Simon Game iOS
//
//  Created by Nunzio Ricci on 02/11/22.
//

import SwiftUI
import AVFoundation

extension TileView {
    
    class ViewModel: ObservableObject {
        @Published var color: Color
        @Published var brighting: Bool = false
        @Published var sound: Int? = nil
        private var _onTap: (()->())? = nil
        var abled: Bool = true
        
        var onTap: (()->())? {
            get {
                if abled {
                    return {
                        Task {
                            await self.tap()
                        }
                        self._onTap?()
                    }
                }
                return nil
            }
            set {
                _onTap = newValue
            }
        }
        
        
        
        init(color: Color, sound: Int? = nil, onTap: (()->())? = nil) {
            self.color = color
            self.sound = sound
            self.brighting = brighting
            self.onTap = onTap
        }
        
        @MainActor
        func animationOn() async {
            withAnimation {
                brighting = true
                onTap!()
            }
        }
        
        @MainActor
        func animationOff() async {
            withAnimation {
                brighting = false
            }
        }
        
        func tap(duration: Double = 1.0) async {
                await animationOn()
                if sound != nil {
                    AudioServicesPlaySystemSound(SystemSoundID(sound!))
                }
                sleep(1)
                await animationOff()
        }
    }
}
