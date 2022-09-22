//
//  WeatherService.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/09/18.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class WeatherService {
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
    
    func getWeather(_ lat: Double, _ lon: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=jinju&&appid=\(apiKey)") else {
            return completion(.failure(.badURL))
        }
        
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
