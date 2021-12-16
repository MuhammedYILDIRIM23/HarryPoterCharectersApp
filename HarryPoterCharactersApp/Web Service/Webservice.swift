//
//  Webservice.swift
//  HarryPoterCharactersApp
//
//  Created by Muhammed YILDIRIM  on 9.10.2021.
//

import Foundation


class Webservice {
    
    func dataDownload(url: URL, completion: @escaping ([Characters]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            if let error = err {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                do {
                    let characterArray = try JSONDecoder().decode([Characters].self, from: data)
                    completion(characterArray)

                } catch {
                    print(error.localizedDescription)
                    
                }
                                
            }
        }.resume()
        
        
        
    }
}
