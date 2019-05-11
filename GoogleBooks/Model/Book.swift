//
//  Book.swift
//  GoogleBooks
//
//  Created by Hammed opejin on 5/11/19.
//  Copyright © 2019 Hammed opejin. All rights reserved.
//

import UIKit

enum BookErrors: Error {
    case missing(String)
}

class Book {
    let id: String
    let title: String
    let authors: [String]
    let publisher: String
    let publishedDate: String
    let description: String
    let imageUrl: String
    
    init?(json: [String: Any]) throws {
        
        guard let bookInfo = json["volumeInfo"] as? [String: Any], let id = json["id"] as? String  else {
            throw BookErrors.missing("Missing Book Id")
        }
        self.id = id
        
        var imageLinks = ["" : ""]
        if let imgLinks = bookInfo["imageLinks"] as? [String: String]  {
            imageLinks = imgLinks
        }
        
        var title = "No Title"
        if let titl = bookInfo["title"] as? String {
            title = titl
        }
        self.title = title
        
        var author = ["Anonmous Author"]
        if let auth = bookInfo["authors"] as? [String] {
            author = auth
        }
        self.authors = author
        
        var publisher = "NA"
        if let pub = bookInfo["publisher"] as? String {
            publisher = pub
        }
        self.publisher = publisher
        
        var publishedDate = "NA"
        if let date = bookInfo["publishedDate"] as? String {
            publishedDate = date
        }
        self.publishedDate = publishedDate
        
        var description = "No description for this book!"
        if let desc = bookInfo["description"] as? String {
            description = desc
        }
        self.description = description
        
        var imageUrl = ""
        if let imgUrl = imageLinks["thumbnail"] {
            imageUrl = imgUrl
        }
        self.imageUrl = imageUrl
        
    }
}
