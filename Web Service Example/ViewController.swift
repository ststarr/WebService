//
//  ViewController.swift
//  Web Service Example
//
//  Created by Al Hammons on 9/13/16.
//  Copyright © 2016 Susan Hammons. All rights reserved.
//  9/13/2016 app id for ststarr user = bbbd58c85a79eb93bc78596c07f681cf
//

import UIKit
//import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var forecastLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let manager = AFHTTPSessionManager()
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=bbbd58c85a79eb93bc78596c07f681cf",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in

                        if let responseObject = responseObject {
                            print("Response: " + responseObject.description)
                        }
                        /*if let listOfDays = responseObject?["list"] as? [AnyObject] {
                            if let tomorrow = listOfDays[0] as? [String:AnyObject] {
                                if let tomorrowsWeather = tomorrow["weather"] as? [AnyObject] {
                                    if let firstWeatherOfDay = tomorrowsWeather[0] as? [String:AnyObject] {
                                        if let forecast = firstWeatherOfDay["description"] as? String {
                                            self.forecastLabel.text = forecast
                                        }
                                    }
                                }
                            }
                        } */
                        let json = JSON(responseObject!)
                        if let forecast = json["list"][0]["weather"][0]["description"].string {
                            self.forecastLabel.text = forecast
                        }
            },
                    failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

