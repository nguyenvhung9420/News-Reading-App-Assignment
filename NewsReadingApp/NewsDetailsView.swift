//
//  NewsDetailsView.swift
//  NewsReadingApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import SwiftUI
import BetterSafariView

struct NewsDetailsView: View {
    
    var article: Article
    @State private var showingSheet = false
    let imgPlaceholders = ["placeholder_1", "placeholder_2"]
    
    var urlToImage: URL {
        return URL(string: article.urlToImage)!
    }
    
    var url: URL {
        return URL(string: article.url)!
    }
    
    var body: some View {
        ScrollView {
        VStack {
            
            AsyncImage(url: self.urlToImage, placeholder: {
                        
                Image(imgPlaceholders.randomElement()!)
                    .resizable()
                
            }) .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(article.title)
                Button(action: {
                    self.showingSheet = true
                }, label: {
                    Text("See more details")
                })
                Text(article.author)
                Text(article.publishedAt)
                Text(article.briefDescription)
                Text(article.content)
            }.padding()
           
            
        }
        }
        .navigationBarTitle(Text("Details"),displayMode: .inline)
        .safariView(isPresented: $showingSheet) {
            SafariView(
                url: self.url,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
            .dismissButtonStyle(.done)
        }
        .animation(.default)
    }
}
