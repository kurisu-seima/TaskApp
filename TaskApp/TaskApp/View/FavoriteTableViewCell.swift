//
//  FavoriteTableViewCell.swift
//  TaskApp
//
//  Created by くりすせいま on 2020/11/03.
//  Copyright © 2020 せいま. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteTitleLabel: UILabel!
    
    @IBOutlet weak var favoriteSubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func favoriteSetUp(favoriteTask: [String: Any]) {
        favoriteTitleLabel.text = favoriteTask["title"] as? String
        favoriteSubtitleLabel.text = favoriteTask["date"] as? String
    }
}
