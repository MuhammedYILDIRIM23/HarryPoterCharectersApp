//
//  CharactersViewModel.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 10.10.2021.
//

import Foundation



struct CharactersTableViewModel {
    
    let charactersList : [Characters]
    
    func numberOfRowInSection() -> Int {
        return self.charactersList.count
    }
    
    func charactersIndexPath(_ index: Int) -> CharactersViewModel {
        let character = self.charactersList[index]
        return CharactersViewModel(characters: character)
    }
    

    
}



struct CharactersViewModel {
    
    let characters : Characters
    
    var name : String {
        return self.characters.name
    }
    var house : String {
        return self.characters.house
    }
    var image: String {
        return self.characters.image
    }
    var species: String {
        return self.characters.species
    }
    var dateOfBirth: String {
        return self.characters.dateOfBirth
    }
    var actor: String {
        return self.characters.actor
    }
    
    
}
