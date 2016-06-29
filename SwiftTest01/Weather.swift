//
//  Weather.swift
//  SwiftTest01
//
//  Created by Khureltulga Dashdavaa on 6/29/16.
//  Copyright © 2016 Khureltulga Dashdavaa. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let temp: Double
    let description: String
    
    init (cityName: String, temp: Double, description: String) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
    }
}
