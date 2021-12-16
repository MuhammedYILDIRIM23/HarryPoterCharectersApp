//
//  FavoriteViewCell.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 12.11.2021.
//

import UIKit

class FavoriteViewCell: UITableViewCell {

    @IBOutlet weak var favoriteNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
