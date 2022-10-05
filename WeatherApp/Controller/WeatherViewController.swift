//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/10/06.
//

import UIKit
import AVFoundation
import Gifu

class WeatherViewController: UIViewController {
    @IBOutlet weak var WeatherAnimationView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playMp4Video(name: "DaySnow")
        // Do any additional setup after loading the view.
    }
    
    private func playMp4Video(name: String) {
            DispatchQueue.main.async { [weak self] in
                self?.playVideo(with: "WeatherVideo/\(name)")
            }
        }
    
    private func playVideo(with resourceName: String) {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "mp4") else {
            return
        }

        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = WeatherAnimationView.bounds
        WeatherAnimationView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
        print("1")
    }

}
