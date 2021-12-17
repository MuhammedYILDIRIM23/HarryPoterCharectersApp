//
//  ViewController.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 8.10.2021.
//

import UIKit
import Kingfisher
import CoreData

class ViewController: UIViewController, FavoriteProtocol {
    
    // MARK: Protocol
    func Upload(_ controller: DetailViewController, with item: Array<String>) {
        coreData.getData()
        tableView.reloadData()
    }
    

    
    private var charactersTableViewModel : CharactersTableViewModel!
    private var coreData = CoreData()
    var detailVC = DetailViewController()
    

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailVC.delegate = self    //  <------------------------------------------------------ MARK: Delegate
        
        tableView.delegate = self
        tableView.dataSource = self
                
        getDataWebservice()
  
        coreData.getData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorilerim", style: .plain, target: self, action: #selector(favoriler))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Takımı Gör", style: .plain, target: self, action: #selector(teamsee))
        
        
    }

    
    
    
    
    func getDataWebservice() {
        
        let url = URL(string: "\(UrlPathConstant.apiUrlPath)")
        guard let url = url else { return }
        Webservice().dataDownload(url: url) { [weak self] character in
            if let character = character {
                self?.charactersTableViewModel = CharactersTableViewModel(charactersList: character)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    @objc func teamsee() {
        performSegue(withIdentifier: IdentifierConstanst.teamSeeIdentifier, sender: nil)
    }

    
    @objc private func favoriler() {
        performSegue(withIdentifier: IdentifierConstanst.favoriteIdentifier, sender: nil)
    }
    
    
    
  
    
    
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersTableViewModel == nil ? 0 : self.charactersTableViewModel.numberOfRowInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstanst.viewCellIdentifier, for: indexPath) as! TableViewCell
        let charactersViewModel = self.charactersTableViewModel.charactersIndexPath(indexPath.row)
        let image = URL(string: "\(charactersViewModel.image)")
        newCell.imageVİew.kf.setImage(with: image)
        if coreData.nameArray.isEmpty == false {
            for name in coreData.nameArray {
                if name == charactersViewModel.name {
                    newCell.favoriteImageView.image = UIImage(named: "favorite2")
                }
            }
            
        }
        newCell.nameLabel.text = charactersViewModel.name
        newCell.houseLabel.text = charactersViewModel.house
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = charactersTableViewModel.charactersIndexPath(indexPath.row)
        performSegue(withIdentifier: IdentifierConstanst.detailIdentifier, sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == IdentifierConstanst.detailIdentifier, let model = sender as?  CharactersViewModel {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.setCharaterModel(model: model)
            destinationVC.delegate = self   // <-------------------------- MARK: Delegate
        }
    }
    
}









