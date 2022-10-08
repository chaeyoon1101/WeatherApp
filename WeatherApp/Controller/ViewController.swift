////
////  ViewController.swift
////  WeatherApp
////
////  Created by 임채윤 on 2022/09/16.
////
//
//import UIKit
//import AVFoundation
//import Gifu
//import CoreLocation
//
//class ViewController: UIViewController, CLLocationManagerDelegate {
//    @IBOutlet weak var scrollbarView: UIView!
//    @IBOutlet weak var scrollView: UIView!
//    
//    @IBOutlet var cityNameLabel: UILabel!
//    @IBOutlet var tempLabel: UILabel!
//    @IBOutlet var weatherDescriptionLabel: UILabel!
//    
//    @IBOutlet var scrollbarTimeLabel01: UILabel!
//    @IBOutlet var scrollbarTimeLabel02: UILabel!
//    @IBOutlet var scrollbarTimeLabel03: UILabel!
//    @IBOutlet var scrollbarTimeLabel04: UILabel!
//    @IBOutlet var scrollbarTimeLabel05: UILabel!
//    @IBOutlet var scrollbarTimeLabel06: UILabel!
//    @IBOutlet var scrollbarTimeLabel07: UILabel!
//    @IBOutlet var scrollbarTimeLabel08: UILabel!
//    @IBOutlet var scrollbarTimeLabel09: UILabel!
//    @IBOutlet var scrollbarTimeLabel10: UILabel!
//    @IBOutlet var scrollbarTimeLabel11: UILabel!
//    @IBOutlet var scrollbarTimeLabel12: UILabel!
//    
//    @IBOutlet var scrollbarTempLabel01: UILabel!
//    @IBOutlet var scrollbarTempLabel02: UILabel!
//    @IBOutlet var scrollbarTempLabel03: UILabel!
//    @IBOutlet var scrollbarTempLabel04: UILabel!
//    @IBOutlet var scrollbarTempLabel05: UILabel!
//    @IBOutlet var scrollbarTempLabel06: UILabel!
//    @IBOutlet var scrollbarTempLabel07: UILabel!
//    @IBOutlet var scrollbarTempLabel08: UILabel!
//    @IBOutlet var scrollbarTempLabel09: UILabel!
//    @IBOutlet var scrollbarTempLabel10: UILabel!
//    @IBOutlet var scrollbarTempLabel11: UILabel!
//    @IBOutlet var scrollbarTempLabel12: UILabel!
//    
//    @IBOutlet var scrollbarIconImageView01: UIImageView!
//    @IBOutlet var scrollbarIconImageView02: UIImageView!
//    @IBOutlet var scrollbarIconImageView03: UIImageView!
//    @IBOutlet var scrollbarIconImageView04: UIImageView!
//    @IBOutlet var scrollbarIconImageView05: UIImageView!
//    @IBOutlet var scrollbarIconImageView06: UIImageView!
//    @IBOutlet var scrollbarIconImageView07: UIImageView!
//    @IBOutlet var scrollbarIconImageView08: UIImageView!
//    @IBOutlet var scrollbarIconImageView09: UIImageView!
//    @IBOutlet var scrollbarIconImageView10: UIImageView!
//    @IBOutlet var scrollbarIconImageView11: UIImageView!
//    @IBOutlet var scrollbarIconImageView12: UIImageView!
//    
//    @IBOutlet weak var animationView: UIImageView!
//    
//    static var hasCurrentLocation: Bool = false
//    static var isAppStatesActive: Bool = false
//    
//    var scrollbarTimeLabels = [UILabel]()
//    
//    var scrollbarTempLabels = [UILabel]()
//
//    var scrollbarIconImageViews = [UIImageView]()
//
//    let weatherService = WeatherService()
//    
//    var main = [MainData]()
//    var weather = [WeatherData]()
//    var dxTxt = [String]()
//    var cityName: String?
//    var country: String?
//    
//    var locationManger = CLLocationManager()
//    
//    var lat: Double = 0
//    var lon: Double = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        scrollView.layer.cornerRadius = 20
//        
//        prepareToGetLocation()
//        scrollbarTimeLabels = [scrollbarTimeLabel01, scrollbarTimeLabel02, scrollbarTimeLabel03, scrollbarTimeLabel04, scrollbarTimeLabel05, scrollbarTimeLabel06, scrollbarTimeLabel07, scrollbarTimeLabel08, scrollbarTimeLabel09, scrollbarTimeLabel10, scrollbarTimeLabel11, scrollbarTimeLabel12]
//
//        scrollbarTempLabels = [scrollbarTempLabel01, scrollbarTempLabel02, scrollbarTempLabel03, scrollbarTempLabel04, scrollbarTempLabel05, scrollbarTempLabel06, scrollbarTempLabel07, scrollbarTempLabel08, scrollbarTempLabel09, scrollbarTempLabel10, scrollbarTempLabel11, scrollbarTempLabel12]
//
//        scrollbarIconImageViews = [scrollbarIconImageView01, scrollbarIconImageView02, scrollbarIconImageView03, scrollbarIconImageView04, scrollbarIconImageView05, scrollbarIconImageView06, scrollbarIconImageView07, scrollbarIconImageView08, scrollbarIconImageView09, scrollbarIconImageView10, scrollbarIconImageView11, scrollbarIconImageView12]
//        
//        allowRequest()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        if locationManger.authorizationStatus == .denied {
//            allowRequest()
//        }
//    }
//    
//    func prepareToGetLocation() {
//        locationManger.delegate = self
//        
//        locationManger.desiredAccuracy = kCLLocationAccuracyBest
//        
//        locationManger.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            print("위치 서비스 On 상태")
//            locationManger.startUpdatingLocation()
//        } else {
//            print("위치 서비스 Off 상태")
//        }
//        
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if ViewController.isAppStatesActive == false { return }
//        if let location = locations.first {
//            lat = location.coordinate.latitude
//            lon = location.coordinate.longitude
//        }
//        
//        if ViewController.hasCurrentLocation == false {
//            weatherService.getWeather(lat, lon) { result in
//                switch result {
//                case .success(let weatherResponse):
//                    DispatchQueue.main.async {
//                        self.cityName = weatherResponse.city?.name
//                        self.country = weatherResponse.city?.country
//                        let weatherResponse = weatherResponse.list
//                        
//                        weatherResponse.forEach {
//                            let main = MainData(temp: Int(round($0.main.temp)))
//                            let weather = WeatherData(main: $0.weather.first?.main, description: $0.weather.first?.description, id: $0.weather.first?.id )
//                            let dxTxt = $0.dt_txt
//                            
//                            self.main.append(main)
//                            self.weather.append(weather)
//                            self.dxTxt.append(dxTxt)
//                        }
//                        print("render")
//                        self.render()
//                    }
//                case .failure(_ ):
//                    print("Error")
//                }
//            }
//            ViewController.hasCurrentLocation = true
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        locationManger.requestWhenInUseAuthorization()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error)
//    }
//    
//    func allowRequest() {
//        let alert = UIAlertController(title: "위치 권한 요청", message: "위치 권한 설정이 거절되어있습니다\n설정에서 위치 권한 설정을 허용으로 변경해주세요", preferredStyle: .actionSheet)
//        
//        alert.addAction(UIAlertAction(title: "확인", style: .default))
//        
//        present(alert, animated: true)
//    }
//    
//    private func playMp4Video(name: String) {
//            DispatchQueue.main.async { [weak self] in
//                self?.playVideo(with: "WeatherVideo/\(name)")
//            }
//        }
//    
//    private func playVideo(with resourceName: String) {
//        guard let path = Bundle.main.path(forResource: resourceName, ofType: "mp4") else {
//            return
//        }
//
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = animationView.bounds
//        animationView.layer.addSublayer(playerLayer)
//        playerLayer.videoGravity = .resizeAspectFill
//        player.play()
//    }
//    
//    private func render() {
//        guard let temp = main.first?.temp,
//              let video = WeatherBackground(rawValue: (weather.first?.description)!)?.video,
//              let weatherId = weather.first?.id else { return }
//        
//        let weatherDescription = WeatherDescription()
//        let cityName = "\(cityName!), \(country!)"
//        let currentTime = isDayTime(currentTime) ? 0 : 1
//        let weatherShortDescription = weatherDescription.shortDescripton(weatherId: weatherId)
//        
//        playMp4Video(name: video[currentTime])
//        cityNameLabel.text = cityName
//        tempLabel.text = "\(temp - 273)°"
//        weatherDescriptionLabel.text = "\(weatherDescription)"
//        
//        for i in 0...11 {
//            guard let icon = WeatherImageIcon(rawValue: (weather[i].description)!)?.icon else { return }
//            let temp = main[i].temp! - 273
//            let time = calculateTimeDiffrence(dxTxt[i])
//            let currentTime = isDayTime(calculateHourTime(dxTxt[i])) ? 0 : 1
//            
//            scrollbarTempLabels[i].text = "\(temp)°"
//            scrollbarTimeLabels[i].text = "\(time)시"
//            scrollbarIconImageViews[i].image = UIImage(systemName: icon[currentTime])
//        }
//    }
//    
//    private func isDayTime(_ time: Int) -> Bool {
//        if time >= 6 && time < 18 {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    private func getWeatherIcon(_ icon: String?) -> Data {
//        guard let icon = icon,
//              let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png"),
//              let data = try? Data(contentsOf: url) else {
//            return Data()
//        }
//
//        return data
//    }
//    
//    private func calculateTimeDiffrence(_ time: String) -> String {
//        guard let time = time.toDate() else {
//            return "데이터 오류"
//        }
//        
//        let dateFormatterTime = DateFormatter()
//        dateFormatterTime.dateFormat = "a HH"
//        var result = dateFormatterTime.string(from: time).components(separatedBy: " ")
//        
//        result[0] = result[0] == "오전" || result[0] == "AM" ? "오전" : "오후"
//        result[1] = Int(result[1])! == 0 ? String(Int(result[1])! + 12) : String(Int(result[1])!)
//        result[1] = Int(result[1])! > 12 ? String(Int(result[1])! - 12) : String(Int(result[1])!)
//        
//        let calculatedTime = "\(result[0]) \(result[1])"
//        
//        return calculatedTime
//    }
//    
//    private func calculateHourTime(_ time: String) -> Int {
//        guard let time = time.toDate() else { return 0 }
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH"
//        let currentTime = dateFormatter.string(from: time)
//        
//        return Int(currentTime)!
//    }
//    
//    private var currentTime: Int {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH"
//        let currentTime = dateFormatter.string(from: Date())
//        
//        return Int(currentTime)!
//    }
//}
