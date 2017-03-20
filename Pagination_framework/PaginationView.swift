//
//  PaginationView.swift
//  Pagination_framework
//
//  Created by LA Argon on 17/03/17.
//  Copyright © 2017 LA Argon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

protocol PaginationDelegate: class {
    func paginationDidStart(activityIndicator: UIActivityIndicatorView)
    func paginationDidFinish(activityIndicator: UIActivityIndicatorView)
    func paginationDidFinish(with json: JSON?, error: Error?, statusCode: Int?)
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
    public var paginationBottomAnchor: NSLayoutConstraint!
    public var scrollView: UIScrollView?
    var targetOffset: CGFloat = 0.0
    public var data = (url: "",
                       parameters: [String: Any](),
                       offset: 0,
                       limit: 20,
                       method: HTTPMethod.get,
                       headers: HTTPHeaders(),
                       page_name: "page",
                       offset_name: "offset",
                       limit_name: "limit")
    
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
    
    func callAPI() {
        
        
    }
}

extension PaginationView: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.y)
        print(scrollView.contentOffset.y)
        if !isPaginating && targetOffset < scrollView.contentOffset.y {
            print(scrollView.contentOffset.y)
            targetOffset = scrollView.contentOffset.y
            if data.url == "" || data.url == "\n" {
                return
            }
            isPaginating = true
            Alamofire.request(data.url, method: data.method, parameters: data.parameters, encoding: URLEncoding.default).responseSwiftyJSON { response in
                delay(time: 2, closure: {
                    self.isPaginating = false
                    self.delegate?.paginationDidFinish(with: response.result.value, error: response.error, statusCode: response.response?.statusCode)
                })
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if targetOffset < scrollView.contentOffset.y {
            print(scrollView.contentOffset.y)
        }
    }
}





