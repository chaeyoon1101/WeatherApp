//
//  WeatherDescription.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/09/21.
//

import Foundation

enum WeatherImageIcon: String {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case scatteredClouds = "scattered clouds"
    case brokenClouds = "broken clouds"
    case overcastClouds = "overcast clouds"
    case showerRain = "shower rain"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case rain = "Rain"
    case thunderstorm = "Thunderstorm"
    case snow = "snow"
    case mist = "mist"
    
    var icon: [String] {
        switch self {
        case .clearSky:
            return ["sun.max.fill", "moon.stars.fill"]
        case .fewClouds:
            return ["cloud.sun.fill", "cloud.moon.fill"]
        case .scatteredClouds, .brokenClouds, .overcastClouds:
            return ["cloud.fill", "cloud.fill"]
        case .showerRain, .lightRain:
            return ["cloud.sun.rain.fill", "cloud.moon.rain.fill"]
        case .moderateRain:
            return ["cloud.heavyrain.fill", "cloud.heavyrain.fill"]
        case .rain:
            return ["cloud.rain.fill", "cloud.rain.fill"]
        case .thunderstorm:
            return ["cloud.bolt.rain.fill", "cloud.bolt.rain.fill"]
        case .snow:
            return ["snow", "snow"]
        case .mist:
            return ["cloud.fog.fill", "cloud.fog.fill"]
        }
    }
}
