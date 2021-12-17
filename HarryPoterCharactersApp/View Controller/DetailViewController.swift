//
//  DetailViewController.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 11.10.2021.
//

import UIKit

// MARK: PROTOCOL
protocol FavoriteProtocol: AnyObject {
    func Upload(_ controller: DetailViewController, with item: Array<String>)
}


class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailHouseLabel: UILabel!
    @IBOutlet weak var detailSpeciesLabel: UILabel!
    @IBOutlet weak var detailDateOfBirthLabel: UILabel!
    @IBOutlet weak var detailActorLabel: UILabel!
    @IBOutlet weak var detailFavoriteImage: UIImageView!
    
    private(set) var characterModel: CharactersViewModel!
    private var coreData: CoreData = CoreData()
    weak var delegate: FavoriteProtocol?    // <------------------ MARK: Delegate
    
    var teamArrayName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        coreData.getData()
        coreData.getTeamData()
        teamArrayName = coreData.teamKaleciArray + coreData.teamDefansArray + coreData.teamOrtaSahaArray + coreData.teamForvetArray
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Takıma Ekle", style: .plain, target: self, action: #selector(detailTeamAdd))
     

        if let model = characterModel {
            detailNameLabel.text = model.name
            detailHouseLabel.text = model.house
            detailSpeciesLabel.text = model.species
            detailDateOfBirthLabel.text = model.dateOfBirth
            detailActorLabel.text = model.actor
            let imageString = URL(string: model.image)
            detailImageView.kf.setImage(with: imageString)
            detailFavoriteIamge(image: detailFavoriteImage)
            
            
        }
        
      
    }
    
    func setCharaterModel(model: CharactersViewModel) {
        characterModel = model
    }
    
 
    
    @objc private func detailTeamAdd() {
        alert()
    }

    private func detailFavoriteIamge(image: UIImageView) {
        if coreData.nameArray.count > 0 {
            for name in coreData.nameArray {
                if name == characterModel.name {
                    image.image = UIImage(named: "favorite2")
                }
            }
        }
        
    }
    
    
    
    func teamFullAlert() {
        let alert = UIAlertController(title: "As Takım Dolu", message: "Yedek kardroya eklensin mi?", preferredStyle: .alert)
        let iptalButton = UIAlertAction(title: "Hayır", style: .cancel) { UIAlertAction in
            self.performSegue(withIdentifier: IdentifierConstanst.teamIdentifier, sender: nil)
        }
        let ekleButton = UIAlertAction(title: "Evet", style: .default) { UIAlertAction in
            self.coreDataTeamSpare()
            self.performSegue(withIdentifier: IdentifierConstanst.teamIdentifier, sender: nil)
        }
        alert.addAction(iptalButton)
        alert.addAction(ekleButton)
        present(alert, animated: true, completion: nil)
    }
    

    func alert() {
        let alert = UIAlertController(title: "Oyuncunun Mevkisini Seç", message: nil, preferredStyle: .actionSheet)
        let kaleciButton = UIAlertAction(title: "Kaleci", style: .default) { [self] UIAlertAction in
            if teamArrayName.count < 11 {
                if teamArrayName.contains(detailNameLabel.text!)  {
                } else {
                    coreData.saveTeamKaleciData(inputName: detailNameLabel.text!)
                }
            } else {
                self.teamFullAlert()
            }
            print("keleci eklendi")
            performSegue(withIdentifier: IdentifierConstanst.teamIdentifier, sender: nil)
        }
        let defansButton = UIAlertAction(title: "Defans", style: .default) { [self] UIAlertAction in
            if teamArrayName.count < 11 {
                if teamArrayName.contains(detailNameLabel.text!)  {
                } else {
                    coreData.saveTeamDefansData(inputName: detailNameLabel.text!)
                }
            } else {
                self.teamFullAlert()
            }
            print("defans eklendi")
            performSegue(withIdentifier: IdentifierConstanst.teamIdentifier, sender: nil)
        }
        let ortaSahaButton = UIAlertAction(title: "Orta Saha", style: .default) { [self] UIAlertAction in
            if teamArrayName.count < 11 {
                if teamArrayName.contains(detailNameLabel.text!)  {
                } else {
                    coreData.saveTeamOrtaSahaData(inputName: detailNameLabel.text!)
                }
            } else {
                self.teamFullAlert()
            }
            print("ortasaha eklendi")
            performSegue(withIdentifier: IdentifierConstanst.teamIdentifier, sender: nil)
        }
        let forvetButton = UIAlertAction(title: "Forvet", style: .default) { [self] UIAlertAction in
            if teamArrayName.count < 11 {
                if teamArrayName.contains(detailNameLabel.text!)  {
                } else {
                    coreData.saveTeamForverData(inputName: detailNameLabel.text!)
                }
            } else {
                self.teamFullAlert()
            }
            print("forvet eklendi")
            performSegue(withIdentifier: IdentifierConstanst.teamIdentifier, sender: nil)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(kaleciButton)
        alert.addAction(defansButton)
        alert.addAction(ortaSahaButton)
        alert.addAction(forvetButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
            
    }
    
    private func newCoreDataTeam(save:() ) {
        if teamArrayName.count < 11 {
            if teamArrayName.contains(detailNameLabel.text!)  {
                print("aynı oyuncu kadroya 2 kere giremez.")
            } else {
                save
                print("başarılı bir şekilde kaydedildi.")
            }
        } else {
            self.teamFullAlert()
            print("Takım dolu error bloğu çalıştı")
        }
    }

    private func coreDataTeamSpare() {
        if self.coreData.teamSpareArray.count < 5 {
            if teamArrayName.contains(self.detailNameLabel.text!) {
                print("bu oyuncu as kadroda bulunmakta.")
            } else {
                if self.coreData.teamSpareArray.contains(self.detailNameLabel.text!) {
                    print("bu oyuncu yedek kadroda zatan kayıtlı.")
                } else {
                    self.coreData.saveTeamSpareData(inputName: self.detailNameLabel.text!)
                    print("yedek kadroya başarılı bir şekilde kaydedildi.")
                }
            }
        } else {
            printContent("yedek kadroda yer kalmadı.")
        }
    }
    
    
    
}



