//
//  FindComicViewController.swift
//  comics_shortcut
//
//  Created by Heine Fjeldberg on 09/11/2022.
//

import UIKit
import CoreData

class FindComicViewController: UIViewController {
    
    @IBOutlet weak var getLatesComicButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var getComicButton: UIButton!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var saveComicButton: UIButton!
    
    
    /*let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   */
    //var container: NSPersistentContainer!
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? SavedComicViewController {
            nextVC.container = container
        }
    }*/
    var comicManager = ComicManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicManager.delegate = self
        searchTextField.delegate = self
    }
}

//MARK: - UITextFieldDelegate

extension FindComicViewController: UITextFieldDelegate {
    @IBAction func getLatesComic(_ sender: UIButton) {
        comicManager.fetchLatestComic()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Try again"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let comic = searchTextField.text {
            comicManager.fetchComic(number: comic)
        }
        searchTextField.text = ""
    }
}

//MARK: - ComicManagerDelegate

extension FindComicViewController: ComicManagerDelegate {
    
    func didUpdateComic(_ comicManager: ComicManager, comic: ComicModel) {
        DispatchQueue.main.async {
            self.comicTitleLabel.text  = comic.title
            self.comicImageView.image = comic.img
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

//MARK: - Core Model functionallity

extension FindComicViewController {
    
    /*func convertImage(img: UIImage) {
        let pngImageData = img.pngData()
        let entity = NSEntityDescription.entity(forEntityName: "ComicCoreModel", in: )
    }*/
    
    /*@IBAction func saveComicsPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Comic", in: context)
        let newComic = Comic(entity: entity!, insertInto: context)
        newComic.id = comicList.count as NSNumber
        newComic.title = comicTitleLabel.text
        //newComic.img = comicImageView
        do {
            try context.save()
            comicList.append(newComic)
            navigationController?.popViewController(animated: true)
        } catch {
            print("Context save error")
        }
        
    }*/
}
    
