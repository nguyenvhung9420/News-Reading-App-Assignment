//
//  TopHeadlinesView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import SwiftUI
import Combine
import BetterSafariView

struct TopHeadlinesView: View {
    
    @EnvironmentObject private var networkDataProvider: NetworkDataProvider
    
    @State private var showingSheet = false
    @State private var choosenUrl: String = ""
    
    var body: some View {
        NavigationView {
            
            
            //        VStack {
            //        Text("\(networkDataProvider.headlineArticles[0].author)")
            
            //        Button(action: {
            //            self.networkDataProvider.setTopHeadlines()
            //        }, label: {
            //            Text("Set")
            //        })
            
            if networkDataProvider.headlineArticles.count == 0 {
                Text("Loading")
            } else  {
                //            Text(networkDataProvider.headlineArticles[0].author)
                List {
                    ForEach(networkDataProvider.headlineArticles, id: \.self) { each in
//                        Button(action: {
//                            self.showingSheet = true
//                            self.choosenUrl = "www.google.fr"
//                        }, label: {
//
//                        })
                        NavigationLink(
                            destination: NewsDetailsView(article: each),
                            label: {
                                Text(each.author)
                                
                            })
                        
                       
                        
                    }
                }
                .animation(.default)
                .navigationBarTitle(Text("Top Headlines"))
                .safariView(isPresented: $showingSheet) {
                    SafariView(
                        url: URL(string: "https://github.com/")!,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: false,
                            barCollapsingEnabled: true
                        )
                    )
                    .dismissButtonStyle(.done)
                }
            }
            
            
            
        }
        
    }
    
}


