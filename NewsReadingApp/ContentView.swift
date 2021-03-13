//
//  ContentView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authProvider: AuthenticationProvider
    @EnvironmentObject private var networkDataProvider: NetworkDataProvider
    
    var body: some View {
//        VStack {
            
//            if authProvider.loggedIn == false {
//                LoginScreen()
//            } else {
                    
                    TabView {
                      TopHeadlinesView()
                            .tabItem {
                                Image(systemName: "waveform.path.ecg")
                                Text("Symptoms")
                        }
                        YourNewsView()
                              .tabItem {
                                  Image(systemName: "waveform.path.ecg")
                                  Text("Symptoms")
                          }
                        PreferencesView()
                            .tabItem {
                                Image(systemName: "person")
                                Text("Yours")
                        }
                        
                    }
                    .onAppear(perform: {
                        self.networkDataProvider.setTopHeadlines()
                    })
                    .animation(.default)
                
                
//            }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
