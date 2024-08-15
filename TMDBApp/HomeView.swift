//
//  HomeView.swift
//  TMDBApp
//
//  Created by luis rodriguez on 15/08/24.
//

import SwiftUI
struct ContentView: View {
    @State private var networkManager = NetworkManager()
    @State private var msg:String = "Verification in 5 seconds"
    @State private var image:String = "circle.dotted.circle"
    @State private var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Label( self.msg , systemImage: self.image)
                .foregroundColor(Color.black)
                .font(.system(size: 20))
        }
        .onReceive(self.timer) { _ in
           
        self.msg =  self.networkManager.checkInternetConnectionDevice()
                self.image = networkManager.getImage()
            }
        }
    
}

#Preview {
    ContentView()
}
