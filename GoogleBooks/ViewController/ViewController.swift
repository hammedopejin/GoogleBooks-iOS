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
    @IBOutlet weak var booksSearchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        booksTableview.delegate = self
        booksTableview.dataSource = self
        
    }


}

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension BooksViewController: UITableViewDelegate {
    
}

