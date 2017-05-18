//
//  ViewController.swift
//  Pagination_framework
//
//  Created by LA Argon on 17/03/17.
//  Copyright © 2017 LA Argon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    struct Movie {
        let name: String
        let year: String
        
        init(name: String, year: String) {
            self.name = name
            self.year = year
        }
    }
    
    // 1 create instance of PaginationView
    let paginationView = PaginationView()
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieData = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setUpPagination() 
    }
    
    // 2 Call this method to setup the pagination.
    func setUpPagination() {
        tableView.superview?.addSubview(paginationView)
        paginationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let con = paginationView.topAnchor.constraint(equalTo: tableView.topAnchor)
        paginationView.paginationBottomAnchor = con
        con.isActive = true
        paginationView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        paginationView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        paginationView.scrollView = tableView
        paginationView.scrollView?.delegate = paginationView
        paginationView.shouldPaginate = true
        paginationView.isPaginating = true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movieData[indexPath.row].name
        cell.detailTextLabel?.text = movieData[indexPath.row].year
        return cell
    }
}
