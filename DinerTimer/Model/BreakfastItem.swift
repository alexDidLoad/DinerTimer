//
//  BreakfastItem.swift
//  DinerTimer
//
//  Created by Alexander Ha on 12/20/20.
//

import UIKit

struct BreakfastItem {
    
    var type: String!
    var method: String!
    var doneness: String!
    
    init(type: String? = "", method: String? = "", doneness: String? = "") {
        
        self.type = type
        self.method = method
        self.doneness = doneness
        
    }
    
}
