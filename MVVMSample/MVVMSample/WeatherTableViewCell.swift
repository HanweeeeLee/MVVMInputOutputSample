//
//  WeatherTableViewCell.swift
//  MVVMSample
//
//  Created by hanwe on 2021/02/05.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
