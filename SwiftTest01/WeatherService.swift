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
}

class WeatherService {
 
    var delegate: WeatherServiceDelegate?
    
    func getWeather (city: String) {
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let appid = "d227062a0b9e11030ead4f61667972f9"

        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=\(appid)"
        
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            // print(">>>>>>> \(data)")
            let json = JSON(data: data!)
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
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
            
            print("Latitute, Lontute: \(lon!), \(lat!),  temperature: \(temp!)")
            print("name: \(name), description: \(description)")
        }
        
        task.resume()
        
        // print("Weather service city: \(city)")
        
        // request weather data ...
        // wait ...
        // process data
        
        // let weather = Weather(cityName: city, temp: 237.12, description: "A nice day")
        
        // delegate?.setWeather(weather)
        
    }
    
}