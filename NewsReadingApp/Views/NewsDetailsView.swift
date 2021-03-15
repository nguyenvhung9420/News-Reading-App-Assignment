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
    
    var formatedDate: String {
        let isoDate = article.publishedAt
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "HH:mm E, d MMM y"
        return (formatter2.string(from: date))
    }
    
    var body: some View {
        ScrollView {
        VStack {
            
            AsyncImage(url: self.urlToImage, placeholder: {
                Image(imgPlaceholders.randomElement()!)
                    .resizable()
                
            })
            .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 20) {
                
                Text(article.title).font(.system(.title)).bold() 
                
                Text(article.author).font(.system(.headline))
                
                Text(self.formatedDate).font(.system(.caption))
                
                Text(article.briefDescription).foregroundColor(.gray)
                
                Text(article.content)
                
                Button(action: {
                    self.showingSheet = true
                }, label: {
                    Text("See more details")
                })
                
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
