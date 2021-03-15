//
//  ChoosingPreferencesView.swift
//  NewsReadingApp
//
//  Created by Hung Nguyen on 14/3/21.
//

import SwiftUI

struct ChoosingPreferencesView: View {
    @EnvironmentObject var auth: AuthenticationProvider
    @EnvironmentObject var networkDataProvider: NetworkDataProvider
    
    @Binding var isPresented: Bool
    
    @State var listToSetToDatabase: [String] = []
    
    private var prefsList: [String] {
        return (self.auth.loggedUser?.getPreferenceList())!
    }
    
    var prefsTemplate: [String] = ["bitcoin", "apple", "earthquake", "animal"]
    
    var body: some View {
        VStack {
            Text("Choose topics you want to add to your preferences")
        
            List {
                ForEach(self.prefsTemplate, id: \.self) { each in
                    Button(action: {
                        if self.prefsList.contains(each) == false {
                            self.auth.loggedUser?.appendToPrefsList(each)
                        } else {
                            self.auth.loggedUser?.removeFromPrefsList(each)
                        }
                        self.auth.retrieveLoggedInUser()
                    }) {
                        HStack {
                            Text(each)
                            Spacer()
                            if prefsList.contains(each) == false {
                                Image(systemName: "star")
                            } else {
                                Image(systemName: "star.fill")
                            }
                        }
                    }
                }
            }
        }
        .onDisappear(perform: {
            self.auth.retrieveLoggedInUser()
        })
    }
}
