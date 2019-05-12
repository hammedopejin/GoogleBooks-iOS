//
//  Entity.swift
//  GoogleBooks
//
//  Created by Hammed opejin on 5/12/19.
//  Copyright © 2019 Hammed opejin. All rights reserved.
//

import UIKit

struct Entity {
    
    struct Keys {
        enum Book: String{
            case CoreBook = "CoreBook"
            case id = "id"
            case title = "title"
            case authors = "authors"
            case publisher = "publisher"
            case publishedDate = "publishedDate"
            case bookDescription = "bookDescription"
            case imageUrl = "imageUrl"
        }
    }
    
    enum Constant: String {
        case GoogleBooks = "GoogleBooks"
    }
}
