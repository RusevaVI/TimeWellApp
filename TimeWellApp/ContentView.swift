import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack( spacing: 20) {
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.leading, 25)
                Text("Добро пожаловать")
                    .font(.rubikTitle(size: 30))
                
                NavigationLink {
                    TimeSetting()
                } label: {
                   Text("Начать")
                        .foregroundColor(Color.white)
                        .font(.rubikTitle(size: 25))
                        .padding(15)
                        .background(Color("customPink"))
                        .cornerRadius(30)
                }
            }
            .padding()
        }
    }
}
