//
//  ContentView.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-09.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//

//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
//}

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            OverView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Overview")
            }.tag(0)
            
            WebView(url: "https://news.google.com/topics/CAAqBwgKMLH2lwswzJ-vAw")
                .tabItem {
                    Image(systemName: "tray.full")
                    Text("News")
            }.tag(1).onAppear{}
            
            SafetyTipsView()
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Safty Tips")
            }.tag(2)
            
            WebView(url: "https://www.who.int/news-room/q-a-detail/q-a-coronaviruses")
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("Q&A")
            }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
