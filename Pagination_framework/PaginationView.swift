//
//  PaginationView.swift
//  Pagination_framework
//
//  Created by LA Argon on 17/03/17.
//  Copyright © 2017 LA Argon. All rights reserved.
//

import UIKit

class PaginationView: UIView {
    
    public var isPaginating = false {
        didSet {
            if isPaginating {
                activityIndicator.startAnimating()
                self.alpha = 1.0
                self.scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.height, right: 0)
            } else {
                activityIndicator.stopAnimating()
                self.alpha = 0.0
                self.scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    public var paginationBottomAnchor: NSLayoutConstraint!
    public var scrollView: UIScrollView?
    var targetOffset: CGFloat = 0.0
    
    public var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setUpActivityIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpActivityIndicator() {
        self.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}


extension PaginationView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reload_distance: CGFloat = 70
        
        if (y > h + reload_distance) && !isPaginating {
            isPaginating = true
            
            delay(time: 5, closure: { 
                self.isPaginating = false
            })
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        paginationBottomAnchor.constant = scrollView.contentSize.height - scrollView.contentOffset.y
    }
}





