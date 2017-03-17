//
//  PaginationView.swift
//  Pagination_framework
//
//  Created by LA Argon on 17/03/17.
//  Copyright © 2017 LA Argon. All rights reserved.
//

import UIKit

protocol PaginationDelegate: class {
    func paginationDidStart(activityIndicator: UIActivityIndicatorView)
    func paginationDidFinish(activityIndicator: UIActivityIndicatorView)
}

class PaginationView: UIView {
    
    var isPaginating = false {
        didSet {
            if isPaginating {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    var scrollView: UIScrollView!
    
    public var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpActivityIndicator()
        scrollView.delegate = self
    }
    
    func setUpActivityIndicator() {
        self.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

extension PaginationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reload_distance: CGFloat = -75 // It will call the API when there is 5 offers are remaining to be displayed. one offer height is 75.
        isPaginating = false
        if y > h + reload_distance {
            isPaginating = true
            delay(time: 3, closure: { 
                self.isPaginating = false
            })
        }
    }
}





