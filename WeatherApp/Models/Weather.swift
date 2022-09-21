//
//  Weather.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/09/18.
//

import Foundation

struct WeatherResponse: Decodable {
    let list: [List]
    let city: City?
}

struct City: Decodable {
    let name: String
    let country: String
}

struct List: Decodable {
    let main: Main
    let weather: [Weather]
    let dt_txt: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
