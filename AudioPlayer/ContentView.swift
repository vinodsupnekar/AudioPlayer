//
//  ContentView.swift
//  AudioPlayer
//
//  Created by Vinod Supnekar on 24/07/23.
//

import SwiftUI
import AVKit
import Combine


struct ContentView: View {

    @ObservedObject var player: Player

    var body: some View {
        
    ZStack {
        VStack {
                Text("Play").font(.system(size: 45)).font(.largeTitle)
            VStack {
                Button(action: {
                    switch self.player.timeControlStatus {
                    case .paused:
                        self.player.play()
                    case .waitingToPlayAtSpecifiedRate:
                        self.player.pause()
                    case .playing:
                        self.player.pause()
                    @unknown default:
                        fatalError()
                    }
                }) {
                    Image(systemName: self.player.timeControlStatus == .paused ? "play.circle.fill" : "pause.circle.fill").resizable()
                        .imageScale(.large)
                        .frame(width: 64, height: 64)
                }
            if self.player.itemDuration > 0 {

                Slider(value: self.$player.displayTime, in: (0...self.player.itemDuration), onEditingChanged: {
                    (scrubStarted) in
                    if scrubStarted {
                        self.player.scrubState = .scrubStarted
                    } else {
                        self.player.scrubState = .scrubEnded(self.player.displayTime)
                    }
                })
            } else {
                Text("Slider will appear here when the player is ready")
                    .font(.footnote)
            }
            }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(player: Player(avPlayer: AVPlayer()))
    }
}
