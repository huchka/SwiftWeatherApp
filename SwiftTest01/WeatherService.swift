//
//  WeatherService.swift
//  SwiftTest01
//
//  Created by Khureltulga Dashdavaa on 6/29/16.
//  Copyright © 2016 Khureltulga Dashdavaa. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather (weather: Weather)
    func weatherErrorWithMessage (message: String)
}

class WeatherService {
 
    var delegate: WeatherServiceDelegate?
    
    func getWeather (city: String) {
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let appid = "d227062a0b9e11030ead4f61667972f9"

        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=\(appid)"
        
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in

            if let httpResponse = response as? NSHTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            let json = JSON(data: data!)
            print(json)
            
            var status = 0
            if let cod = json["cod"].int {
                status = cod
            } else if let cod = json["cod"].string {
                status = Int(cod)!
            }
            
            if status == 200 {
                let temp = json["main"]["temp"].double
                let name = json["name"].string
                let description = json["weather"][0]["description"].string
                let icon = json["weather"][0]["icon"].string
                
                let weather = Weather(cityName: name!, temp: temp!, description: description!, icon: icon!)
                
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.delegate?.setWeather(weather)
                    })
                }
            } else if status == 404 {
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.delegate?.weatherErrorWithMessage("City not found")
                    })
                }
            } else {
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.delegate?.weatherErrorWithMessage("Unknown error occured on response")
                    })
                }
            }
            
        }
        
        task.resume()
    }
    
}