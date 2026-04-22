import SwiftUI
import Combine

struct MainView: View {
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    @State private var timeRemaining: Int = 0
    @State private var isCheated = false
    @State private var isScreenLocked = false
    
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            if isCheated {
                Spacer()
                Image("cryCat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                Text("Ты не справился")
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("01"))
                    .font(.rubikTitle(size: 30))
                Spacer()
            } else if timeRemaining == 0 {
                ZStack{
                    StarVideoView()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .scaleEffect(2)
                        
                    VStack{
                        
                        Text("Ты молодец!")
                            .font(.rubikBold(size: 60))
                            .foregroundColor(Color("02"))
                        Image("happyCat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .padding(.top, 70)
                    }
                }
                
            } else {
                
                VStack(spacing: 10) {
                    Text("Осталось:")
                        .font(.rubikTitle(size: 30))
                        .foregroundStyle(Color("01"))
                    
                    Text(formatTime(timeRemaining))
                        .font(.rubikBold(size: 60))
                        .foregroundStyle(Color("01"))
                    BackgroundVideoView()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .scaleEffect(1.3)
                        .clipped()
                        .padding(.leading,70)
                }
                     
                
                
            }
        }
        .padding()
        
        .onAppear {
            timeRemaining = (hours * 3600) + (minutes * 60) + seconds
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 && !isCheated {
                timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.protectedDataWillBecomeUnavailableNotification)) { _ in
            isScreenLocked = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.protectedDataDidBecomeAvailableNotification)) { _ in
            isScreenLocked = false
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                
                
                if !isScreenLocked && timeRemaining > 0 {
                    isCheated = true
                    
                }
            }
        }
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let h = totalSeconds / 3600
        let m = (totalSeconds % 3600) / 60
        let s = totalSeconds % 60
        if h > 0 {
            return String(format: "%d:%02d:%02d", h, m, s)
        } else {
            return String(format: "%02d:%02d", m, s)
        }
    }
}

