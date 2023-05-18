//
//  FavouriteCell.swift
//  SportsApp
//
//  Created by Rafeef Esam on 10/05/2023.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var favTeamName: UILabel!
    @IBOutlet weak var favTeamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
