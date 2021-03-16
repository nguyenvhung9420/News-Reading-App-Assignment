//
//  NewsReadingAppTests.swift
//  NewsReadingAppTests
//
//  Created by Hung Nguyen on 13/3/21.
//

import XCTest
import Alamofire
import SwiftyJSON
import Combine

@testable import NewsReadingApp

class NewsReadingAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIfLoggedUsernameInNSUserDefault() throws {
        XCTAssert((UserDefaults.standard.string(forKey: "logged_in_username") != nil),"logged_in_username in NSUserDefaults is null.")
    }
    
    func testTopHeadlinesFetchable()  {
        let e = expectation(description: "Alamofire")
        let apiKey : String = "7c2214b601964c49aa795389054f8643"
        let apiUrl: String = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)"
        
        var respondedArrayOfArticles: [Article] = []
        
        AF.request(apiUrl, method: .get).response { response in
            do {
                guard let data = response.data else {
                    print("There is no connection, please try again...")
                    return
                }
                
                let json = try JSON(data: data)
                 
                json["articles"].arrayValue.forEach {
                    var sourceName: String = ""
                    if let source = $0["source"]["name"].stringValue as? String  {
                        sourceName = source
                    }
                    
                    XCTAssert(sourceName != "", "There is no source name data")
                    
                    var article = Article()
                    article.source = sourceName
                    article.author = $0["author"].stringValue
                    article.briefDescription = $0["description"].stringValue
                    article.content = $0["content"].stringValue
                    article.title = $0["title"].stringValue
                    article.publishedAt = $0["publishedAt"].stringValue
                    article.urlToImage = $0["urlToImage"].stringValue
                    article.url = $0["url"].stringValue
                    
                    respondedArrayOfArticles.append(article)
                    print(article.author)
                }
                print("Done fetching articles")
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssert(respondedArrayOfArticles.count != 0, "Could not fetch the data from API")
    }
    
    func testPreferedNewsFetchable()  {
        let e = expectation(description: "Alamofire")
        let apiKey : String = "7c2214b601964c49aa795389054f8643"
        let apiUrl: String = "https://newsapi.org/v2/everything?q=business+apple&apiKey=\(apiKey)"
        
        var respondedArrayOfArticles: [Article] = []
        
        AF.request(apiUrl, method: .get).response { response in
            do {
                guard let data = response.data else {
                    print("There is no connection, please try again...")
                    return
                }
                
                let json = try JSON(data: data)
                 
                json["articles"].arrayValue.forEach {
                    var sourceName: String = ""
                    if let source = $0["source"]["name"].stringValue as? String  {
                        sourceName = source
                    }
                    
                    XCTAssert(sourceName != "", "There is no source name data")
                    
                    var article = Article()
                    article.source = sourceName
                    article.author = $0["author"].stringValue
                    article.briefDescription = $0["description"].stringValue
                    article.content = $0["content"].stringValue
                    article.title = $0["title"].stringValue
                    article.publishedAt = $0["publishedAt"].stringValue
                    article.urlToImage = $0["urlToImage"].stringValue
                    article.url = $0["url"].stringValue
                    
                    respondedArrayOfArticles.append(article)
                    print(article.author)
                }
                print("Done fetching articles")
            } catch {
                print("Unexpected error: \(error).")
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssert(respondedArrayOfArticles.count != 0, "Could not fetch the data from API")
    }

}
