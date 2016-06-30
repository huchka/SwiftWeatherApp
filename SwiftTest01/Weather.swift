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
    let icon: String
    
    var tempC: Double {
        return temp - 273.15
    }
    
    init (cityName: String, temp: Double, description: String, icon: String) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
    }
}
