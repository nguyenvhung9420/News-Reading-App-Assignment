//
//  NetworkProvider.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import Alamofire
import Combine
import Foundation
import SwiftyJSON

class NetworkDataProvider: ObservableObject {
    private let apiKey: String = "7c2214b601964c49aa795389054f8643"
    
    @Published var headlineArticles: [Article] = []
    
    @Published var preferedArticles: [Article] = []
    
    static var instance = NetworkDataProvider()
    
    func setTopHeadlines() {
        self.getTopHeadlines()
        print(self.$headlineArticles.count)
    }
    
    func getPreferedNews(_ preferenceList: [String]) {
        var prefs: String = ""
       print("Getting prefered news as \(preferenceList)")
        if preferenceList.count == 0 {
            prefs = "business"
        } else {
            prefs = preferenceList.joined(separator: "+")
        }
        
        let apiUrl: String = "https://newsapi.org/v2/everything?q=\(prefs)&apiKey=\(apiKey)"
        
        AF.request(apiUrl, method: .get).response { response in
            do {
                guard let data = response.data else {
                    return
                }
                let json = try JSON(data: data)
                self.preferedArticles.removeAll()
                json["articles"].arrayValue.forEach {
                    var sourceName: String = ""
                    if let source = $0["source"]["name"].stringValue as? String {
                        sourceName = source
                    }
                    var article = Article()
                    article.source = sourceName
                    article.author = $0["author"].stringValue
                    article.briefDescription = $0["description"].stringValue
                    article.content = $0["content"].stringValue
                    article.title = $0["title"].stringValue
                    article.publishedAt = $0["publishedAt"].stringValue
                    article.urlToImage = $0["urlToImage"].stringValue
                    article.url = $0["url"].stringValue
                    
                    self.preferedArticles.append(article)
                }
                print("Done fetching prefered articles")
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        
        print("It returned \(self.headlineArticles.count)")
    }
    
    func getTopHeadlines() {
        let apiUrl: String = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
         
        AF.request(apiUrl, method: .get).response { response in
            do {
                guard let data = response.data else {
                    print("There is no connection, please try again...")
                    return
                }
                let json = try JSON(data: data)
                 
                json["articles"].arrayValue.forEach {
                    var sourceName: String = ""
                    if let source = $0["source"]["name"].stringValue as? String {
                        sourceName = source
                    }
                    var article = Article()
                    article.source = sourceName
                    article.author = $0["author"].stringValue
                    article.briefDescription = $0["description"].stringValue
                    article.content = $0["content"].stringValue
                    article.title = $0["title"].stringValue
                    article.publishedAt = $0["publishedAt"].stringValue
                    article.urlToImage = $0["urlToImage"].stringValue
                    article.url = $0["url"].stringValue
                    
                    self.headlineArticles.append(article)
                }
                print("Done fetching articles")
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        
        print("It returned \(self.headlineArticles.count)")
    }
}


