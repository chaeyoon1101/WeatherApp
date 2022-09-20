//
//  ViewController.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/09/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var feelsLikeTempLabel: UILabel!
    
    let weatherService = WeatherService()
    
    var main = [MainData]()
    var weather = [WeatherData]()
    var dxTxt = [String]()
    var cityName: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.cityName = weatherResponse.city?.name
                    self.country = weatherResponse.city?.country
                    let weatherResponse = weatherResponse.list
                    
                    weatherResponse.forEach {
                        let main = MainData(temp: Int(round($0.main.temp)), feelsLike: Int(round($0.main.feels_like)))
                        let weather = WeatherData(main: $0.weather.first?.main, icon: $0.weather.first?.icon)
                        let dxTxt = $0.dt_txt
                        
                        self.main.append(main)
                        self.weather.append(weather)
                        self.dxTxt.append(dxTxt)
                    }
                    self.render()
                }
            case .failure(_ ):
                print("Error")
            }
        }
    }
    
    private func render() {
        guard let icon = weather.first?.icon,
              let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png"),
              let data = try? Data(contentsOf: url) else { return }
        
        let temp = main.first?.temp!
        let feelsLikeTemp = main.first?.feelsLike
        let cityName = "\(cityName!), \(country!)"
        
        weatherIconImageView.image = UIImage(data: data)
        cityNameLabel.text = cityName
        tempLabel.text = "\(temp! - 273)°"
        feelsLikeTempLabel.text = "체감온도 \(feelsLikeTemp! - 273)°"
    }


}

