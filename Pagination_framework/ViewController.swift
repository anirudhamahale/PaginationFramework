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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        paginationView.activityIndicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

