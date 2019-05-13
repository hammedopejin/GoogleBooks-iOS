//
//  GoogleBooksTests.swift
//  GoogleBooksTests
//
//  Created by Hammed opejin on 5/10/19.
//  Copyright © 2019 Hammed opejin. All rights reserved.
//

import XCTest
@testable import GoogleBooks

class GoogleBooksTests: XCTestCase {

    var downloadService: DownloadService!
    var dataService: DataService!
    var books: [Book]!
    var favorites: [Book]!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        downloadService = DownloadService.shared
        dataService = DataService.sharedInstance
        let bookVC = BooksViewController()
        books = bookVC.books
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertTrue(books.isEmpty)
        
    }
    
    func testSearchBook () {
        
        //var books = [Book]()
        let promise = expectation(description: "waiting for books...")
        
            downloadService.getBooks(searchTerm: "Love", vc: UIViewController()) {[unowned self] bks in
                
                if let resultbooks = bks {
                    self.books = resultbooks
                }
                
                promise.fulfill()
                
            }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertTrue(books.count > 0)
        
    }
    
    func testSearchBookandSaveFavorite () {
        
        //var books = [Book]()
        let promise = expectation(description: "waiting for books...")
        
        downloadService.getBooks(searchTerm: "Love", vc: UIViewController()) {[unowned self] bks in
            
            if let resultbooks = bks {
                self.books = resultbooks
                self.dataService.saveBook(self.books[0])
                self.favorites = self.dataService.getBooks()
            }
            
            promise.fulfill()
            
        }
        
        waitForExpectations(timeout: 4, handler: nil)
        
        XCTAssertTrue(favorites.count > 0)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
