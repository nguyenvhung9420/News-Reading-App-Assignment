//
//  TopHeadlinesView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import ActivityIndicatorView
import BetterSafariView
import Combine
import SwiftUI

struct TopHeadlinesView: View {
    @EnvironmentObject private var networkDataProvider: NetworkDataProvider
    
    @State private var showingSheet = false
    @State private var choosenUrl: String = ""
    
    @State private var showLoading: Bool = true
    
    var body: some View {
        NavigationView {
            if networkDataProvider.headlineArticles.count == 0 {
                VStack {
                    ActivityIndicatorView(isVisible: $showLoading, type: .default)
                        .frame(width: 50.0, height: 50.0)
                    Text("Loading")
                }
                
            } else {
                List {
                    ForEach(networkDataProvider.headlineArticles, id: \.self) { each in
                        NavigationLink(
                            destination: NewsDetailsView(article: each),
                            label: {
                                HStack(alignment: .top)  {
                                    if each.getImageUrl() != nil {
                                        AsyncImage(url: each.getImageUrl()!, placeholder: {
                                            ActivityIndicatorView(isVisible: $showLoading, type: .default)
                                                .frame(width: 20.0, height: 20.0)
                                        })
                                        .scaledToFill()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60).cornerRadius(8)
                                        .clipped()
                                    } else {
                                        Text(each.title.prefix(1))
                                            .frame(width: 60, height: 60)
                                            .background(Color.gray)
                                            .cornerRadius(8)
                                    }
                                    
                                    Spacer().frame(width: 12, height:1)
                                    VStack(alignment: .leading) {
                                        Text(each.title).font(.system(.body)).bold()
                                        Spacer().frame(width: 0, height: 7)
                                        Text(each.briefDescription.prefix(40)).font(.system(.caption)).foregroundColor(.gray)
                                    }
                                }
                               
                                
                            })
                    }
                }
                .navigationBarTitle(Text("Top Headlines"))
                .animation(.default)
                .onAppear {
                    
                }
            }
        }
    }
}
