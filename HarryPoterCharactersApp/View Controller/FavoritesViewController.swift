//
//  FavoritesViewController.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 10.10.2021.
//

import UIKit


class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
        
    private let coreData = CoreData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        coreData.getData()
        
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreData.nameArray.isEmpty == true ? 0 : coreData.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteCell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstanst.viewCellIdentifier , for: indexPath) as! FavoriteViewCell
        let nameIndex = coreData.nameArray[indexPath.row]
        favoriteCell.favoriteNameLabel.text = nameIndex
        return favoriteCell
    }
    

    
    
    
}
