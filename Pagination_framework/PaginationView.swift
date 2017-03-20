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
    
    public var isPaginating = false {
        didSet {
            if isPaginating {
                activityIndicator.startAnimating()
                self.alpha = 1.0
                self.delegate?.paginationDidStart(activityIndicator: activityIndicator)
                self.scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
            } else {
                activityIndicator.stopAnimating()
                self.alpha = 0.0
                self.delegate?.paginationDidFinish(activityIndicator: activityIndicator)
                self.scrollView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    public var delegate: PaginationDelegate?
    
    public var scrollView: UIScrollView?
    
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
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        
        let reload_distance: CGFloat = -75 // It will call the API when there is 5 offers are remaining to be displayed. one offer height is 75.
        if (y > h + reload_distance) && !isPaginating  {
            isPaginating = true
            delay(time: 5, closure: {
                self.isPaginating = false
            })
        }
    }
    
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        if !isPaginating  {
            isPaginating = true
            delay(time: 5, closure: {
                self.isPaginating = false
            })
        }
    }
 */
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isPaginating && targetContentOffset.pointee.y > 0.0 {
            isPaginating = true
            delay(time: 5, closure: {
                self.isPaginating = false
            })
        }
    }
}





