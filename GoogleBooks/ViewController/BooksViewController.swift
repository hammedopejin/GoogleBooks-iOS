//
//  ViewController.swift
//  GoogleBooks
//
//  Created by Hammed opejin on 5/10/19.
//  Copyright © 2019 Hammed opejin. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    @IBOutlet weak var booksTableview: UITableView!
    
    var resultSearchController = UISearchController()
    
    var books = [Book]() {
        didSet{
            booksTableview.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableview ()
    }

    
    func setUpTableview() {
        
        booksTableview.delegate = self
        booksTableview.dataSource = self
        booksTableview.register(UINib(nibName: "BooksTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: BooksTableViewCell.identifier)
        booksTableview.tableFooterView = UIView(frame: .zero)
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            booksTableview.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    
    
    func getBooks(searchTerm: String) {
        let endpoint = "https://www.googleapis.com/books/v1/volumes?q=\(searchTerm)"
        
        guard let url = URL(string: endpoint) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let error = err {
                    print(error)
            }
            
            if let data = data {
                do {
                    if let jsonObjectCount = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let bookCount = jsonObjectCount["totalItems"] as? Int {
                        if bookCount == 0 {
                            print("No Results")
                        }
                    }
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let bookArray = jsonObject["items"] as? [[String: Any]] else {
                            print("Bad Json Format Error!")
                        return
                    }
                    
                    var books = [Book]()
                    for book in bookArray {
                        if let book = try Book(json: book) {
                            books.append(book)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        print("Books count: \(books.count)")
                        if !books.isEmpty {
                            self.books = books
                        }
                    }
                    
                } catch {
                       
                        print(data.debugDescription)
                        print("Couldn't Serialize Object: \(error.localizedDescription)")
                    }
                }
            }.resume()
        
    }

}

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BooksTableViewCell.identifier, for: indexPath) as! BooksTableViewCell
        
        let book = books[indexPath.row]
        
        cell.configureCell(book: book)
        
        return cell
    }
    
    
}

extension BooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension BooksViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
//        if let searchTerm = searchController.searchBar.text {
//            getBooks(searchTerm: searchTerm)
//        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            getBooks(searchTerm: searchTerm)
        }
    }
}


