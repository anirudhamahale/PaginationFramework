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
    
    let paginationView = PaginationView()
    @IBOutlet weak var tableView: UITableView!
    
    var movieData = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpPagination() 
    }
    
    func setUpPagination() {
        paginationView.data.url = "http://www.omdbapi.com/?s=th&page=1"
        tableView.superview?.addSubview(paginationView)

        paginationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let con = paginationView.topAnchor.constraint(equalTo: tableView.topAnchor)
        paginationView.paginationBottomAnchor = con
        con.isActive = true
        paginationView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        paginationView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        paginationView.scrollView = tableView
        paginationView.scrollView?.delegate = paginationView
        paginationView.delegate = self
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

extension ViewController: PaginationDelegate {
    func paginationDidStart(activityIndicator: UIActivityIndicatorView) {
        print("Did Start")
    }
    
    func paginationDidFinish(activityIndicator: UIActivityIndicatorView) {
        print("Did Finish")
    }
    
    func paginationDidFinish(with json: JSON?, error: Error?, statusCode: Int?) {
        if error != nil {
            return
        }
        
        if statusCode == 200 {
            guard let readableJson = json else {
                return
            }
            
            guard let search = readableJson["Search"].array else {
                return
            }
            
            for item in search {
                let name = item["Title"].string ?? ""
                let year = item["Year"].string ?? ""
                movieData.append(Movie(name: name, year: year))
            }
            tableView.reloadData()
        }
    }
}











