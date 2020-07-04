//
//  WeatherModel.swift
//  Climate
//
//  Created by Hanoudi on 7/4/20.
//  Copyright © 2020 Hanan. All rights reserved.
//
//  The structure of the weather model contains the pieces if info that we will store
//  the retrived data from the response and put it in a swift object Weather model
//  the weather model will contain the condition ID, city name, tempaerture
//  in order to be able to display the double number in main.storyboard label we convert
//  it to a string with 1 decimal place.
//  we create a computed property that upon changing returns the conditionName which
//  is the name of the system images that will be displayed

import Foundation


struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
