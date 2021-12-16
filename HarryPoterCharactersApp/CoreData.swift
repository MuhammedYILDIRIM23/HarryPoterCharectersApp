//
//  CoreData.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 13.10.2021.
//

import Foundation
import UIKit
import CoreData


final class CoreData {
    var nameArray = [String]()
    // team arrays
    var teamKaleciArray: [String] = []
    var teamDefansArray: [String] = []
    var teamOrtaSahaArray: [String] = []
    var teamForvetArray: [String] = []
    var teamSpareArray: [String] = []

    


    // Favorite CoreData
    func saveData(inputName: String) {
        saveDefault(entityName: "Favorite", chosenName: inputName, forkey: "name")
    }

    func getData() {
        nameArray.removeAll(keepingCapacity: false)
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let getData = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        getData.returnsDistinctResults = false
        do {
            let results = try context.fetch(getData)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        nameArray.append(name)
                    }
                }
            }
        } catch {
            print("error")
        }
    }

    func deleteData(inputName: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate .persistentContainer.viewContext
        nameArray.removeAll(keepingCapacity: false)
        let deleteData = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        deleteData.predicate = NSPredicate(format: "name = %@", inputName)
        deleteData.returnsDistinctResults = false
        do {
            let results = try? context.fetch(deleteData)
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    if name == inputName {
                        context.delete(result)
                    }
                    do {
                        try context.save()
                        print("Favorite Delete \(name)")
                    } catch {
                        print("Error")
                    }
                }
            }
        }
 
        
    }
    

    
    // MARK: Team Save and Get
    func saveTeamKaleciData(inputName: String) {
        saveDefault(entityName: "Team", chosenName: inputName, forkey: "kaleci")
    }
    func saveTeamDefansData(inputName: String) {
        saveDefault(entityName: "Team", chosenName: inputName, forkey: "defans")
    }
    func saveTeamOrtaSahaData(inputName: String) {
        saveDefault(entityName: "Team", chosenName: inputName, forkey: "ortasaha")
    }
    func saveTeamForverData(inputName: String) {
        saveDefault(entityName: "Team", chosenName: inputName, forkey: "forvet")
    }
    func saveTeamSpareData(inputName: String) {
        saveDefault(entityName: "Team", chosenName: inputName, forkey: "namespare")
    }

    func getTeamData() {
        teamKaleciArray.removeAll(keepingCapacity: false)
        teamDefansArray.removeAll(keepingCapacity: false)
        teamOrtaSahaArray.removeAll(keepingCapacity: false)
        teamForvetArray.removeAll(keepingCapacity: false)
        teamSpareArray.removeAll(keepingCapacity: false)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let getData = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        getData.returnsDistinctResults = false
        do {
            let results = try context.fetch(getData)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "kaleci") as? String {
                        teamKaleciArray.append(name)
                    }
                    if let name = result.value(forKey: "defans") as? String {
                        teamDefansArray.append(name)
                    }

                    if let name = result.value(forKey: "ortasaha") as? String {
                        teamOrtaSahaArray.append(name)
                    }

                    if let name = result.value(forKey: "forvet") as? String {
                        teamForvetArray.append(name)
                    }

                    if let namespare = result.value(forKey: "namespare") as? String {
                        teamSpareArray.append(namespare)
                    }

                }
            }
        } catch {
            print("error")
        }
    }


    
    
    func saveDefault(entityName: String, chosenName: String, forkey: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate .persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        saveData.setValue(chosenName, forKey: forkey)
        do {
            try context.save()
            print("Favorite successful \(chosenName)")
        } catch {
            print("error")
        }
    }
    
    
    
    
    
    
    
    /*
    // MARK: Look
    func deleteTeamData(array: Array<String>, formatName: String, indexPath: IndexPath) {
        var arrayParametre = array
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let arrayIndexPath = arrayParametre[indexPath.row]
        let deleteData = NSFetchRequest<NSFetchRequestResult>(entityName: "Team")
        deleteData.predicate = NSPredicate(format: "\(formatName) = %@", arrayIndexPath)
        deleteData.returnsDistinctResults = false
        do {
            let results = try context.fetch(deleteData)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "\(formatName)") as? String {
                        if name == arrayIndexPath {
                            context.delete(result)
                            arrayParametre.remove(at: indexPath.row)
                        
                        }
                        do {
                            try context.save()
                            print("Team Delete \(name)")
                        } catch {
                            print("Error")
                        }
                    }
                }
            }

        } catch {
            print("DELETE ERROR")
        }
    }
     */
  
}




