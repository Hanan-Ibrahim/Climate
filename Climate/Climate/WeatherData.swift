//
//  WeatherData.swift
//  Climate
//
//  Created by Hanoudi on 7/4/20.
//  Copyright © 2020 Hanan. All rights reserved.
//
//  Conform to the protocol Codable to be able to decode ad encode custom data -> JSON
//  to native Swift objects, it MAPS JSON objects to Swift objects and vice-versa.

import Foundation

//  We need the city name, temperature, description and ID for knowing whether its stormy sunny etc
//  The city name is in the first level and is an object not within any other object
//  The temperature exists within an obj called main uder key named temp
//  The weather description exits within a JSON object array with one object having
//  several keys one of which is id required.
//  Make sure that name main and weather (temp, id description) spell exactly the same as the JSON response

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
