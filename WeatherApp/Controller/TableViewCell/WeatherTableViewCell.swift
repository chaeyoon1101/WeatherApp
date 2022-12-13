//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by 임채윤 on 2022/12/14.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var lowestTempLabel: UILabel!
    @IBOutlet weak var highestTempLabel: UILabel!
    
    override func prepareForReuse() {
        weatherImage.image = nil
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
