//
//  DetailViewController.swift
//  GoogleBooks
//
//  Created by Hammed opejin on 5/11/19.
//  Copyright © 2019 Hammed opejin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookPublishedDate: UILabel!
    @IBOutlet weak var bookDescription: UITextView!
    @IBOutlet weak var bookPublisher: UILabel!
    
    var book: Book!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViews()
    }
    

    func bindViews() {
        bookTitle.text = book.title
        bookAuthors.text = book.authors.joined(separator: ", ")
        bookPublishedDate.text = book.publishedDate
        bookDescription.text = book.description
        bookPublisher.text = book.publisher
        
        let url = book.imageUrl
        DLService.downloadImage(url: url) {[unowned self] image in
            let img = image != nil ? image : #imageLiteral(resourceName: "gift-boxes-icon")
            
            DispatchQueue.main.async {
                self.bookImage.image = img
            }
        }
    }

}
