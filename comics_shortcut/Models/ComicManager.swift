//
//  ComicManager.swift
//  comics_shortcut
//
//  Created by Heine Fjeldberg on 09/11/2022.
//

import Foundation
import UIKit

protocol ComicManagerDelegate {
    func didUpdateComic(_ comicManager: ComicManager, comic: ComicModel)
    func didFailWithError(error: Error)
}

struct ComicManager {
    
    let latestComicURL = "https://xkcd.com/info.0.json"
    
    var delegate: ComicManagerDelegate?
    
    
    func fetchLatestComic() {
        let urlString = latestComicURL
        performRequest(with: urlString)
    }
    
    func fetchComic(number: String) {
        let urlString = "https://xkcd.com/\(number)/info.0.json"
        performRequest(with: urlString)
    }
    
    // Retrieves the data from the API and parses the data to desired format
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let comic = self.parseJSON(safeData) {
                        
                        self.delegate?.didUpdateComic(self, comic: comic)
                    }
                }
            }
            task.resume()
        }
    }
    
    // takes a DataObjekt returned by the api and returns it as a ComicModel
    
    func parseJSON(_ comicData: Data) -> ComicModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ComicData.self, from: comicData)
            let title = decodedData.title
            let num = decodedData.num
            let img = decodedData.img
            let image = getImage(from: img)
            
            let comic = ComicModel(title: title, num: num, img: image!)
            return comic
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    // converts the image retrieved from the API to a UIImage
    
    func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string)
        else {
            print("Kunne ikke lage URL")
            return nil
        }
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        
        return image
    }
}
