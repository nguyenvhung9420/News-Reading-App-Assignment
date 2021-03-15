//
//  ContentView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authProvider: AuthenticationProvider
    @EnvironmentObject var networkDataProvider: NetworkDataProvider
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var loggedIn: Bool = false
    
    var body: some View {
        
        if UserDefaults.standard.string(forKey: "logged_in_username") == nil {
            LoginScreen(onPressLogIn: {
                self.loggedIn = true
            })
        } else {
            TabView {
                TopHeadlinesView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Headlines")
                    }
                YourNewsView()
                    .tabItem {
                        Image(systemName: "star")
                        Text("Your news")
                    }
                PreferencesView(onPressLogOut: {
                    self.loggedIn = false
                }).tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }
            .onAppear(perform: {
                self.authProvider.retrieveLoggedInUser()
                self.networkDataProvider.setTopHeadlines()
                self.networkDataProvider.getPreferedNews((self.authProvider.loggedUser?.getPreferenceList())!)
            })
            .animation(.default)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
