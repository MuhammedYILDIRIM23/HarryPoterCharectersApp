//
//  TableViewCell.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 8.10.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    let coreData = CoreData()
    var charactersTableViewModel : CharactersTableViewModel!
    var isFavorite: Bool?
    
    @IBOutlet weak var imageVİew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteImageView.isUserInteractionEnabled = true
        let favoriteGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFavImage))
        favoriteImageView.addGestureRecognizer(favoriteGestureRecognizer)
 

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @objc func tapFavImage() {
        
        if isFavorite == true {
            favoriteImageView.image = UIImage(named: "favorite2")
            coreData.saveData(inputName: nameLabel.text!)
            isFavorite = false
            
        } else {
            favoriteImageView.image = UIImage(named: "favorite1")
            coreData.deleteData(inputName: nameLabel.text!)
            isFavorite = true
            
        }
       
    }
    
    func favoriteShow(model: CharactersTableViewModel, indexPath: IndexPath) {
        if coreData.nameArray.isEmpty == false {
            for name in coreData.nameArray {
                let modell = model.charactersIndexPath(indexPath.row)
                if name == modell.name {
                    favoriteImageView.image = UIImage(named: "favorite2")
                }
            }
            
        }
        
    }
    

}
