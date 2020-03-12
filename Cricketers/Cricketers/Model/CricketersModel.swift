//
//  CricketersModel.swift
//  Cricketers
//
//  Created by Adaikalraj on 11/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

// MARK:- Model to store cricketers data.

class CricketersModel{
    
    var id: Int
    var name: String
    var description: String
    var image: String    
    
    init(id: Int, name: String, description: String, image: String) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
    }
}
