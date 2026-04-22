import SwiftUI
import AVKit
struct StarVideoView: View {
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "star", withExtension: "mov")!)

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                player.preventsDisplaySleepDuringVideoPlayback = true
                player.isMuted = true
                player.play()
                
                
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                    player.seek(to: .zero)
                    player.play()
                }
            }
            .disabled(true)
            .ignoresSafeArea()
    }
}
