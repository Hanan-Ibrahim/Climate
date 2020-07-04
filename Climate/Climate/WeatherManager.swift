//
//  WeatherManager.swift
//  Climate
//
//  Created by Hanoudi on 7/4/20.
//  Copyright © 2020 Hanan. All rights reserved.
//
//  CoreLocation to determine the devices locations (long,lat, orientation etc)
//  The WeatherManager is responsible for sending the request and storing response
//  As swift objects, we first create the baseURL "weatherURL" and append appkeyTO its end
//  Key is from angela's course on Udemy and specify the return as metric by adding units
//  as metric type.
//  To make this code resuable to any app using openweather we create a protocol
//  that requires the implementation of two functions didUpdateWeather &
//  didFailWithError

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}



struct WeatherManager {
    
    // base URL containing KEY and units as metric
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e72ca729af228beabd5d20e3b7749713&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    //  fetch Weather takes city name from UITextField and appends it to the end of URL
    //  using queries with symbol "q" as per documentation of the utilized API
    //  Then performs a request to fetch for weather using city name
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    //  Same as the function above execpt it takes longitudal and latitudal  as params
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    //  Creates a request given the URL
    func performRequest(with urlString: String) {
        // 1. Create the url
        // 2. Create the url session like browser
        // 3. give task for broswer
        // 4. start task
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
       
            /* session.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>) */
            // Creates a GET Request
            let task = session.dataTask(with: url) { (data, response, error) in
                // safely upwrap contents
                if error != nil {
                    // pass on error to delegate
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        // notify delegate with weather response
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    // parse/resolve data returned into a weather model using a decoder.
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
       
        let decoder = JSONDecoder()
        do {
           // decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}


