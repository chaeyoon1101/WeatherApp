//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/10/06.
//

import UIKit
import AVFoundation
import Gifu
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var WeatherAnimationView: UIImageView!
    
    @IBOutlet weak var WeatherScrollbar: UIScrollView!
    @IBOutlet weak var WeatherScrollView: UIView!
    
    @IBOutlet weak var WeatherRegionLabel: UILabel!
    @IBOutlet weak var WeatherTempLabel: UILabel!
    @IBOutlet weak var WeatherShortDescriptionLabel: UILabel!
    
    @IBOutlet weak var scrollbarTimeLabel01: UILabel!
    @IBOutlet weak var scrollbarTimeLabel02: UILabel!
    @IBOutlet weak var scrollbarTimeLabel03: UILabel!
    @IBOutlet weak var scrollbarTimeLabel04: UILabel!
    @IBOutlet weak var scrollbarTimeLabel05: UILabel!
    @IBOutlet weak var scrollbarTimeLabel06: UILabel!
    @IBOutlet weak var scrollbarTimeLabel07: UILabel!
    @IBOutlet weak var scrollbarTimeLabel08: UILabel!
    @IBOutlet weak var scrollbarTimeLabel09: UILabel!
    @IBOutlet weak var scrollbarTimeLabel10: UILabel!
    @IBOutlet weak var scrollbarTimeLabel11: UILabel!
    @IBOutlet weak var scrollbarTimeLabel12: UILabel!
    
    @IBOutlet weak var scrollbarTempLabel01: UILabel!
    @IBOutlet weak var scrollbarTempLabel02: UILabel!
    @IBOutlet weak var scrollbarTempLabel03: UILabel!
    @IBOutlet weak var scrollbarTempLabel04: UILabel!
    @IBOutlet weak var scrollbarTempLabel05: UILabel!
    @IBOutlet weak var scrollbarTempLabel06: UILabel!
    @IBOutlet weak var scrollbarTempLabel07: UILabel!
    @IBOutlet weak var scrollbarTempLabel08: UILabel!
    @IBOutlet weak var scrollbarTempLabel09: UILabel!
    @IBOutlet weak var scrollbarTempLabel10: UILabel!
    @IBOutlet weak var scrollbarTempLabel11: UILabel!
    @IBOutlet weak var scrollbarTempLabel12: UILabel!
    
    @IBOutlet weak var scrollbarImageView01: UIImageView!
    @IBOutlet weak var scrollbarImageView02: UIImageView!
    @IBOutlet weak var scrollbarImageView03: UIImageView!
    @IBOutlet weak var scrollbarImageView04: UIImageView!
    @IBOutlet weak var scrollbarImageView05: UIImageView!
    @IBOutlet weak var scrollbarImageView06: UIImageView!
    @IBOutlet weak var scrollbarImageView07: UIImageView!
    @IBOutlet weak var scrollbarImageView08: UIImageView!
    @IBOutlet weak var scrollbarImageView09: UIImageView!
    @IBOutlet weak var scrollbarImageView10: UIImageView!
    @IBOutlet weak var scrollbarImageView11: UIImageView!
    @IBOutlet weak var scrollbarImageView12: UIImageView!
    
    var scrollbarTimeLabels = [UILabel]()
    var scrollbarTempLabels = [UILabel]()
    var scrollbarImageViews = [UIImageView]()
    
    let weatherService = WeatherService()
    
    var locationManger = CLLocationManager()
    
    var main = [MainData]()
    var weather = [WeatherData]()
    var dxTxt = [String]()
    var cityName: String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSetDisplay()
        prepareToGetLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        weatherService.getWeather(lat, lon) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.cityName = weatherResponse.city?.name
                    self.country = weatherResponse.city?.country
                    let weatherResponse = weatherResponse.list
                    
                    weatherResponse.forEach {
                        let main = MainData(temp: Int(round($0.main.temp)))
                        let weather = WeatherData(main: $0.weather.first?.main, description: $0.weather.first?.description, id: $0.weather.first?.id )
                        let dxTxt = $0.dt_txt
                        
                        self.main.append(main)
                        self.weather.append(weather)
                        self.dxTxt.append(dxTxt)
                    }
                    print("render")
                    self.render()
                }
            case .failure(_ ):
                print("Error")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManger.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    private func prepareToGetLocation() {
        locationManger.delegate = self
        
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManger.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManger.startUpdatingLocation()
        } else {
            print("위치 서비스 Off 상태")
            locationManger.stopUpdatingLocation()
        }
    }
    
    private func render() {
        guard let temp = main.first?.temp,
              let video = WeatherBackground(rawValue: (weather.first?.description)!)?.video,
              let weatherId = weather.first?.id else { return }

        let weatherDescription = WeatherDescription()
        let cityName = "\(cityName!), \(country!)"
        let currentTime = isDayTime(currentTime) ? 0 : 1
        let weatherShortDescription = weatherDescription.shortDescripton(weatherId: weatherId)
        
        playMp4Video(name: video[currentTime])
        WeatherRegionLabel.text = cityName
        WeatherTempLabel.text = "\(temp - 273)°"
        WeatherShortDescriptionLabel.text = "\(weatherShortDescription)"
        
        let scrollbarCount = 0...11
        for i in scrollbarCount {
            guard let icon = WeatherImageIcon(rawValue: (weather[i].description)!)?.icon else { return }
            let temp = main[i].temp! - 273
            let time = calculateTimeDiffrence(dxTxt[i])
            let currentTime = isDayTime(calculateHourTime(dxTxt[i])) ? 0 : 1
            
            scrollbarTempLabels[i].text = "\(temp)°"
            scrollbarTimeLabels[i].text = "\(time)시"
            scrollbarImageViews[i].image = UIImage(systemName: icon[currentTime])
        }
    }
    
    private func playMp4Video(name: String) {
        DispatchQueue.main.async { [weak self] in
            self?.playVideo(with: "WeatherVideo/\(name)")
        }
    }
    
    private func playVideo(with resourceName: String) {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "mp4") else { return }

        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = WeatherAnimationView.bounds
        WeatherAnimationView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
    }

    private func prepareSetDisplay() {
        scrollbarTimeLabels = [scrollbarTimeLabel01, scrollbarTimeLabel02, scrollbarTimeLabel03, scrollbarTimeLabel04, scrollbarTimeLabel05, scrollbarTimeLabel06, scrollbarTimeLabel07, scrollbarTimeLabel08, scrollbarTimeLabel09, scrollbarTimeLabel10, scrollbarTimeLabel11, scrollbarTimeLabel12]

        scrollbarTempLabels = [scrollbarTempLabel01, scrollbarTempLabel02, scrollbarTempLabel03, scrollbarTempLabel04, scrollbarTempLabel05, scrollbarTempLabel06, scrollbarTempLabel07, scrollbarTempLabel08, scrollbarTempLabel09, scrollbarTempLabel10, scrollbarTempLabel11, scrollbarTempLabel12]

        scrollbarImageViews = [scrollbarImageView01, scrollbarImageView02, scrollbarImageView03, scrollbarImageView04, scrollbarImageView05, scrollbarImageView06, scrollbarImageView07, scrollbarImageView08, scrollbarImageView09, scrollbarImageView10, scrollbarImageView11, scrollbarImageView12]
        WeatherScrollbar.layer.cornerRadius = 20
        WeatherScrollView.layer.cornerRadius = 20
    }
    
    private func isDayTime(_ time: Int) -> Bool {
        if time >= 6 && time < 18 {
            return true
        } else {
            return false
        }
    }
    
    private func calculateTimeDiffrence(_ time: String) -> String {
        guard let time = time.toDate() else { return "데이터 오류" }
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "a HH"
        var result = dateFormatterTime.string(from: time).components(separatedBy: " ")
        
        result[0] = result[0] == "오전" || result[0] == "AM" ? "오전" : "오후"
        result[1] = Int(result[1])! == 0 ? String(Int(result[1])! + 12) : String(Int(result[1])!)
        result[1] = Int(result[1])! > 12 ? String(Int(result[1])! - 12) : String(Int(result[1])!)
        
        let calculatedTime = "\(result[0]) \(result[1])"
        
        return calculatedTime
    }
    
    private func calculateHourTime(_ time: String) -> Int {
        guard let time = time.toDate() else { return 0 }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentTime = dateFormatter.string(from: time)
        
        return Int(currentTime)!
    }
    
    private var currentTime: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentTime = dateFormatter.string(from: Date())
        
        return Int(currentTime)!
    }
}
