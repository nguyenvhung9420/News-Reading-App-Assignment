//
//  YourNewsView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import SwiftUI
import SwiftUIRefresh
import ActivityIndicatorView

struct YourNewsView: View {
    @EnvironmentObject var auth: AuthenticationProvider
    @EnvironmentObject var networkDataProvider: NetworkDataProvider
    @State private var isShowingLoadingIndicator = false
    
    @State private var showLoading: Bool = true
    
    var body: some View {
        NavigationView {
                    List {
                        ForEach(networkDataProvider.preferedArticles, id: \.self) { each in
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
                                        
                                        Spacer().frame(width: 7, height:1)
                                        VStack(alignment: .leading) {
                                            Text(each.title).font(.system(.body)).bold()
                                            Spacer().frame(width: 0, height: 12)
                                            Text(each.briefDescription.prefix(40)).font(.system(.caption)).foregroundColor(.gray)
                                        }
                                    }
                                   
                                    
                                })
                        }
                    }
                    .onAppear(perform: {
                        print("\((auth.loggedUser?.getPreferenceList())!)") 
                            self.networkDataProvider.getPreferedNews((auth.loggedUser?.getPreferenceList())!)
                            self.isShowingLoadingIndicator = false
                    })
                    .navigationBarTitle(Text("Your news"), displayMode: .inline)
                    .animation(.default)
                
            
        }
    }
} 
