//
//  SavedComicsViewController.swift
//  comics_shortcut
//
//  Created by Heine Fjeldberg on 09/11/2022.
//


 //The intention with this tableViewController was to populate it with saved comics from the FindComicsViewController.
 
import UIKit
import CoreData

var comicList = [Comic]()

class SavedComicViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let comicCell = tableView.dequeueReusableCell(withIdentifier: "comicCellId", for: indexPath) as! ComicCell
        
        let thisComic: Comic!
        thisComic = comicList[indexPath.row]
        
        comicCell.titleLabel.text = thisComic.title
        
        return comicCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
