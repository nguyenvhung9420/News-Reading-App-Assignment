//
//  PreferencesView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var auth: AuthenticationProvider
    @EnvironmentObject var networkProvider: NetworkDataProvider
    @State var showModalChoosingPrefs: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var prefsList: [String] = []
    
    var onPressLogOut: () -> Void
    init(onPressLogOut: @escaping () -> Void = {}) {
        self.onPressLogOut = onPressLogOut
    }
    
    var body: some View {
        NavigationView {
            if auth.loggedUser != nil {
                List {
                    ForEach(auth.loggedUser!.getPreferenceList(), id: \.self) { each in
                        Text("\(each)")
                    }
                }.listStyle(PlainListStyle())
                .navigationBarTitle(Text((auth.loggedUser?.username)!))
                .navigationBarItems( trailing: NavigationLink(destination:
                                                                ChoosingPreferencesView(isPresented: $showModalChoosingPrefs)
                                                                .environmentObject(auth)
                                                                .environmentObject(networkProvider)) {
                                        Image(systemName: "plus")
                                    })
                .animation(.default)
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
