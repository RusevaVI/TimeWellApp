import SwiftUI

struct TimeSetting: View {
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    
    var body: some View {
        ZStack {
            Color("customBeige")
                .ignoresSafeArea()
            VStack {
                Text("Сколько планируешь не брать телефон?")
                    .font(.rubikTitle(size: 30))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center) //
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                
                HStack {
                    Picker("Часы", selection: $hours) {
                        ForEach(0..<24) { i in
                            Text("\(i) ч")
                                .font(.rubikTitle(size: 20))
                                .foregroundStyle(.white)
                                .tag(i)
                        }
                    }
                    
                    Picker("Минуты", selection: $minutes) {
                        ForEach(0..<60) { i in
                            Text("\(i) м")
                                .font(.rubikTitle(size: 20))
                                .foregroundStyle(.white)
                                .tag(i)
                        }
                    }
                    
                    Picker("Секунды", selection: $seconds) {
                        ForEach(0..<60) { i in
                            Text("\(i) с")
                                .font(.rubikTitle(size: 20))
                                .foregroundStyle(.white)
                                .tag(i)
                        }
                    }
                }
                .pickerStyle(.wheel)
                
                NavigationLink(destination: MainView(hours: hours, minutes: minutes, seconds: seconds)) {
                    Text("Подтвердить")
                        .font(.rubikTitle(size: 20))
                        .foregroundStyle(.white)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("customBrown"))
                .disabled(hours == 0 && minutes == 0 && seconds == 0)
                .opacity(hours == 0 && minutes == 0 && seconds == 0 ? 0.5 : 1)
            }
        }
        
    }
    
}
