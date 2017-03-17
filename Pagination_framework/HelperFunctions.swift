//
//  HelperFunctions.swift
//  Pagination_framework
//
//  Created by LA Argon on 17/03/17.
//  Copyright © 2017 LA Argon. All rights reserved.
//

import UIKit

func delay(time: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) { 
        closure()
    }
}
