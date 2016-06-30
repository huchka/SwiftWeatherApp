//
//  ViewController.swift
//  SwiftTest01
//
//  Created by Khureltulga Dashdavaa on 6/29/16.
//  Copyright © 2016 Khureltulga Dashdavaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {

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
                                // print("OK")
                                let textField = alert.textFields?[0]
                                // print(textField?.text)
                                self.cityLabel.text = textField?.text!
                                self.weatherService.getWeather((textField?.text)!)
        }
        
        alert.addAction(ok)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Weather Service Delegate
    
    func setWeather(weather: Weather) {
        // print("****** set weather ")
        // print("City \(weather.cityName) temp: \(weather.temp) description: \(weather.description)")
        cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.tempC)"
        descriptionLabel.text = weather.description
        print("weather icon name : \(weather.icon)")
        iconImage.image = UIImage(named: weather.icon)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

