//
//  ViewController.swift
//  Pagination_framework
//
//  Created by LA Argon on 17/03/17.
//  Copyright © 2017 LA Argon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var paginationView: PaginationView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
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
}











