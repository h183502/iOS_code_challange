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
    
    var firstLoad = true
    
    override func viewDidLoad() {
        //if (firstLoad) {
        //    firstLoad = false
        //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        //    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Comic")
        //    do {
        //        let results: NSArray = try context.fetch(request) as NSArray
        //        for result in results {
        //            let comic = result as! Comic
        //            comicList.append(comic)
        //        }
        //    } catch {
        //        print("fetch failed")
        //    }
        //}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let comicCell = tableView.dequeueReusableCell(withIdentifier: "comicCellId", for: indexPath) as! ComicCell
        
        let thisComic: Comic!
        thisComic = comicList[indexPath.row]
        
        comicCell.titleLabel.text = thisComic.title
        comicCell.comicNumberLabel.text = thisComic.comicNumber
        
        return comicCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showComic", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showComic") {
            let indexPath = tableView.indexPathForSelectedRow!
            
            let comicDetail = segue.destination as? ComicDetailController
            
            let selectedComic : Comic!
            selectedComic = comicList[indexPath.row]
            comicDetail!.selectedComic = selectedComic
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
