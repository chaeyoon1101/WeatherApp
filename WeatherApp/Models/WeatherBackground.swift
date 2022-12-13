//
//  WeatherBackground.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/09/22.
//

import Foundation

enum WeatherBackground: String {
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

    var video: [String] {
        switch self {
        case .clearSky:
            return ["DayClearSky", "NightClearSky"]
        case .fewClouds:
            return ["DayClearSky", "NightFewClouds"]
        case .scatteredClouds, .brokenClouds, .overcastClouds:
            return ["DayClouds", "NightClouds"]
        case .showerRain, .lightRain, .moderateRain, .rain:
            return ["DayRain", "NightRain"]
        case .thunderstorm:
            return ["DayThunderStorm", "NightThunderStorm"]
        case .snow:
            return ["DaySnow", "NightSnow"]
        case .mist:
            return ["DayMist", "NightMist"]
        }
    }
}
