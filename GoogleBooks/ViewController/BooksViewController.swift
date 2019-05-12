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
        
        setupTableView ()
    }
    
    func setupTableView() {
        
        booksTableview.delegate = self
        booksTableview.dataSource = self
        booksTableview.register(UINib(nibName: "BooksTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: BooksTableViewCell.identifier)
        booksTableview.tableFooterView = UIView(frame: .zero)
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchBar.delegate = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.tintColor = .black
            controller.searchBar.placeholder = "Search Google Books"
            booksTableview.tableHeaderView = controller.searchBar
            
            return controller
        })()

        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.book = self.books[indexPath.row]
        self.resultSearchController.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BooksViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            //getBooks(searchTerm: searchTerm)
            
            downloadService.getBooks(searchTerm: searchTerm, vc: self) { [unowned self] bks in
                
                if let books = bks {
                    self.books = books
                }
            }
        }
    }
}


