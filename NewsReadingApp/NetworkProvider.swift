//
//  NetworkProvider.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON


class NetworkDataProvider: ObservableObject {
    private var countryCode : String = "fr"
    private let apiKey: String = "7c2214b601964c49aa795389054f8643"
    @Published var headlineArticles: [Article] = []
    
    static var instance = NetworkDataProvider()
    
    func setTopHeadlines() {
        getTopHeadlines()
        print(self.$headlineArticles.count)
    }
    
    func getTopHeadlines()  {
        let apiUrl: String = "https://newsapi.org/v2/top-headlines?country=\(countryCode)&apiKey=\(apiKey)"
        
        AF.request(apiUrl, method: .get).response { response in
            do {
                guard let data =  response.data else {
                    fatalError()
                }
                let json = try JSON(data: data)
                
                //                let articles: [Article] =
                json["articles"].arrayValue.forEach {
                    
                    var sourceName: String =  ""
                    if let source = $0["source"]["name"].stringValue as? String {
                        sourceName = source
                    }
                    var article =  Article()
                    article.source = sourceName
                    article.author = $0["author"].stringValue
                    article.briefDescription = $0["description"].stringValue
                    article.content = $0["content"].stringValue
                    article.title = $0["title"].stringValue
                    article.publishedAt = $0["publishedAt"].stringValue
                    article.urlToImage = $0["urlToImage"].stringValue
                    article.url = $0["url"].stringValue
                    print(article.author)
                    
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

struct Article:  Codable, Hashable {
    
    var source : String = ""
    var name : String = ""
    var author: String = ""
    var title: String =  ""
    var briefDescription: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt:  String = ""
    var content : String = ""
    
    func getDate() -> Date {
        let isoDate = self.publishedAt
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case name = "name"
        case author = "author"
        case title =  "title"
        case briefDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt  = "publishedAt"
        case content  = "content"
    }
    
}
