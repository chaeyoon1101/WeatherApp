# WeatherApp
> ### CoreLocation Library와 날씨 OpenAPI를 활용한 날씨 앱 프로젝트

<br>

<img src="https://user-images.githubusercontent.com/84975077/221421870-33445959-df9d-4fde-96f5-42fb052ae139.jpeg" width="30%">

## 현재 위치의 날씨 정보를 가져오기
```swift
private var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist") else {
            fatalError("'APIKey.plist' 파일을 찾을 수 없습니다.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let value = plist?.object(forKey: "OPENWEATHERMAP_KEY") as? String else {
            fatalError("'APIKey.plist'파일의 'OPHENWEATHERMAP_KEY' 키를 찾을 수 없습니다.")
        }
        
        return value
    }
    
    public func getWeather(_ lat: Double, _ lon: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)") else {
            return completion(.failure(.badURL))
        }
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return completion(.failure(.noData))
                }
                
                let decoder = JSONDecoder()
                let weatherResponse = try? decoder.decode(WeatherResponse.self, from: data)
            
                if let weatherResponse = weatherResponse {
                    completion(.success(weatherResponse))
                } else {
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    }
```

## OpenAPI 파싱 모델
```swift
struct WeatherResponse: Codable {
    let list: [List]
    let city: City?
}

struct City: Codable {
    let name: String
    let country: String
}

struct List: Codable {
    let main: Main
    let weather: [Weather]
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dtTxt = "dt_txt"
        case main, weather
    }
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case temp
    }
}

struct Weather: Codable {
    let main: String
    let description: String
    let id: Int
}
```

## 날씨별 백그라운드 동영상 
```swift
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
```
