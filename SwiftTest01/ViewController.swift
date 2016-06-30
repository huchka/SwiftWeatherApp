//
//  ViewController.swift
//  SwiftTest01
//
//  Created by Khureltulga Dashdavaa on 6/29/16.
//  Copyright © 2016 Khureltulga Dashdavaa. All rights reserved.
//

import UIKit
import CoreLocation // 1 import CoreLocation


class ViewController: UIViewController, WeatherServiceDelegate, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!

    let weatherService = WeatherService()
 
    @IBAction func setCityTap(sender: UIButton) {
        print("city button tapped")
        openCityAlert()
    }
    
    func openCityAlert () {
        let alert = UIAlertController(title: "City",
                                      message: "Enter city name",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: UIAlertActionStyle.Cancel,
                                   handler: nil)
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "Ok",
                               style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                                let textField = alert.textFields?[0]
                                self.weatherService.getWeatherWithCity((textField?.text)!)
        }
        
        alert.addAction(ok)
        
        let location = UIAlertAction(title: "Use Location", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            self.getGPSLocation()
        }
        
        alert.addAction(location)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Weather Service Delegate Methods
    
    func setWeather(weather: Weather) {
        cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.tempC)"
        descriptionLabel.text = weather.description
        print("weather icon name : \(weather.icon)")
        iconImage.image = UIImage(named: weather.icon)
        
    }
    
    func weatherErrorWithMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(ok)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func getGPSLocation () {
        print("Starting location Manager")
        locationManager.startUpdatingLocation()
    }

    // 6 Add delegate methods
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        // Get weather for location
        print("Did update To Location")
        print(newLocation)
        locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did update locations")
        print(locations)
        self.weatherService.getWeatherForLocation(locations[0])
        locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location error \(error) \(error.userInfo)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

