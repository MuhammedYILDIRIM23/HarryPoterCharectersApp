//
//  TeamViewController.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 19.11.2021.
//

import UIKit
import CoreData

class TeamViewController: UIViewController{
    
    private var coreData: CoreData = CoreData()
    
    let titleArray: [String] = ["KALECİ", "DEFANS OYUNCULARI", "ORTA SAHA OYUNCULARI","FORVET OYUNCULARI","YEDEK OYUNCULARI"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        coreData.getTeamData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(teamAdd))

        print("-------------------------------------------------------------------------------------------------------------------------------------------------------------")
        print("yedek kadro: \(coreData.teamSpareArray)")

    }
    // sourctree deneme

    @objc func teamAdd() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowCount = 1
        
        switch (section) {
        case 0:
            if coreData.teamKaleciArray.isEmpty {
            } else {
                rowCount = coreData.teamKaleciArray.count
            }
        case 1:
            if coreData.teamDefansArray.isEmpty {
            } else {
                rowCount = coreData.teamDefansArray.count
            }
        case 2:
            if coreData.teamOrtaSahaArray.isEmpty {
            } else {
                rowCount = coreData.teamOrtaSahaArray.count
            }
        case 3:
            if coreData.teamForvetArray.isEmpty {
            } else {
                rowCount = coreData.teamForvetArray.count
            }
        default:
            if coreData.teamSpareArray.isEmpty {
            } else {
                rowCount = coreData.teamSpareArray.count
            }
        }
        return rowCount
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teamCell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstanst.viewCellIdentifier, for: indexPath) as! TeamTableViewCell
        
        
        switch (indexPath.section) {
        case 0:
            if coreData.teamKaleciArray.isEmpty {
                teamCell.teamCellNameLabel.textColor = UIColor.lightGray
                teamCell.teamCellNameLabel.text = "Takımın kalecisi bulunmamaktadır."
            } else {
                teamCell.teamCellNameLabel.text = coreData.teamKaleciArray[indexPath.row]
            }
        case 1:
            if coreData.teamDefansArray.isEmpty {
                teamCell.teamCellNameLabel.textColor = UIColor.lightGray
                teamCell.teamCellNameLabel.text = "Takımda defans oyuncusu bulunmamaktadır."
            } else {
                teamCell.teamCellNameLabel.text = coreData.teamDefansArray[indexPath.row]
            }
        case 2:
            if coreData.teamOrtaSahaArray.isEmpty {
                teamCell.teamCellNameLabel.textColor = UIColor.lightGray
                teamCell.teamCellNameLabel.text = "Takımda orta saha oyuncusu bulunmamaktadır.."
            } else {
                teamCell.teamCellNameLabel.text = coreData.teamOrtaSahaArray[indexPath.row]
            }

        case 3:
            if coreData.teamForvetArray.isEmpty {
                teamCell.teamCellNameLabel.textColor = UIColor.lightGray
                teamCell.teamCellNameLabel.text = "Takımın forvet oyuncusu bulunmamaktadır."
            } else {
                teamCell.teamCellNameLabel.text = coreData.teamForvetArray[indexPath.row]
            }
        default:
            if coreData.teamSpareArray.isEmpty {
                teamCell.teamCellNameLabel.textColor = UIColor.lightGray
                teamCell.teamCellNameLabel.text = "Yedek kadroda oyuncu bulunmamaktadır."
            } else {
                teamCell.teamCellNameLabel.text = self.coreData.teamSpareArray[indexPath.row]
            }
        }
        return teamCell
        
    }
    // title
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
 
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textColor = UIColor.red
        headerText.adjustsFontSizeToFitWidth = true
        switch section{
        case 0:
            headerText.textAlignment = .center
            headerText.text = titleArray[0]
        case 1:
            headerText.textAlignment = .center
            headerText.text = titleArray[1]
        case 2:
            headerText.textAlignment = .center
            headerText.text = titleArray[2]
        case 3:
            headerText.textAlignment = .center
            headerText.text = titleArray[3]
        default:
            headerText.textAlignment = .center
            headerText.text = titleArray[4]
        }

        return headerText
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Sil"
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        

        if titleArray[indexPath.section] == "KALECİ" {
            
            if editingStyle == .delete {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
                let nameIndex = coreData.teamKaleciArray[indexPath.row]
                fetchRequest.predicate = NSPredicate(format: "kaleci = %@", nameIndex)
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "kaleci") as? String {
                                if name == nameIndex {
                                    context.delete(result)
                                    coreData.teamKaleciArray.remove(at: indexPath.row)
                                    print("\(name) silindi")
                                    self.tableView.reloadData()
                                    
                                    do {
                                        try context.save()
                                    }catch{
                                        print("Error")
                                    }
                                    break
                                }
                                
                                
                            }
                        }
                    }
                }catch{
                    print("ERROR")
                    
                }
            }
            
        } else if titleArray[indexPath.section] == "DEFANS OYUNCULARI"   {
            
            if editingStyle == .delete {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
                let nameIndex = coreData.teamDefansArray[indexPath.row]
                fetchRequest.predicate = NSPredicate(format: "defans = %@", nameIndex)
                fetchRequest.returnsObjectsAsFaults = false
                
                
                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "defans") as? String {
                                if name == nameIndex {
                                    context.delete(result)
                                    coreData.teamDefansArray.remove(at: indexPath.row)
                                    print("\(name) silindi")
                                    self.tableView.reloadData()
                                    
                                    do {
                                        try context.save()
                                    }catch{
                                        print("Error")
                                    }
                                    break
                                }
                                
                                
                            }
                        }
                    }
                }catch{
                    print("ERROR")
                    
                }
            }
        } else if titleArray[indexPath.section] == "ORTA SAHA OYUNCULARI"   {
            
            if editingStyle == .delete {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
                let nameIndex = coreData.teamOrtaSahaArray[indexPath.row]
                fetchRequest.predicate = NSPredicate(format: "ortasaha = %@", nameIndex)
                fetchRequest.returnsObjectsAsFaults = false
                
                
                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "ortasaha") as? String {
                                if name == nameIndex {
                                    context.delete(result)
                                    coreData.teamOrtaSahaArray.remove(at: indexPath.row)
                                    print("\(name) silindi")
                                    self.tableView.reloadData()
                                    
                                    do {
                                        try context.save()
                                    }catch{
                                        print("Error")
                                    }
                                    break
                                }
                                
                                
                            }
                        }
                    }
                }catch{
                    print("ERROR")
                    
                }
            }
        } else if titleArray[indexPath.section] == "FORVET OYUNCULARI"   {
            
            if editingStyle == .delete {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
                let nameIndex = coreData.teamForvetArray[indexPath.row]
                fetchRequest.predicate = NSPredicate(format: "forvet = %@", nameIndex)
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "forvet") as? String {
                                if name == nameIndex {
                                    context.delete(result)
                                    coreData.teamForvetArray.remove(at: indexPath.row)
                                    print("\(name) silindi")
                                    self.tableView.reloadData()
                                    
                                    do {
                                        try context.save()
                                    }catch{
                                        print("Error")
                                    }
                                    break
                                }
                                
                                
                            }
                        }
                    }
                }catch{
                    print("ERROR")
                    
                }            }
        } else if titleArray[indexPath.section] == "YEDEK OYUNCULARI"   {
            
            if editingStyle == .delete {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
                let nameIndex = coreData.teamSpareArray[indexPath.row]
                fetchRequest.predicate = NSPredicate(format: "namespare = %@", nameIndex)
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        for result in results as! [NSManagedObject] {
                            if let name = result.value(forKey: "namespare") as? String {
                                if name == nameIndex {
                                    context.delete(result)
                                    coreData.teamSpareArray.remove(at: indexPath.row)
                                    print("\(name) silindi")
                                    self.tableView.reloadData()
                                    
                                    do {
                                        try context.save()
                                    }catch{
                                        print("Error")
                                    }
                                    break
                                }
                                
                                
                            }
                        }
                    }
                }catch{
                    print("ERROR")
                    
                }
            }
        }
        
    }
    
    
}
