//
//  Article.swift
//  NewsReadingApp
//
//  Created by Hung Nguyen on 16/3/21.
//

import Foundation

struct Article: Codable, Hashable {
    var source: String = ""
    var name: String = ""
    var author: String = ""
    var title: String = ""
    var briefDescription: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
    
    func getDate() -> Date {
        let isoDate = self.publishedAt
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: isoDate)!
        return date
    }
    
    func getImageUrl() -> URL?{
        if let url: URL = URL(string: self.urlToImage) {
            return url
        } else {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case source
        case name
        case author
        case title
        case briefDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
}
