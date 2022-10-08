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
