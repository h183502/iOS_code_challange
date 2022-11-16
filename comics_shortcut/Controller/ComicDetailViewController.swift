//
//  ComicDetailViewController.swift
//  comics_shortcut
//
//  Created by Heine Fjeldberg on 16/11/2022.
//

import UIKit
import CoreData

class ComicDetailController: UIViewController {
    
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicNumberLabel: UILabel!
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var saveComicButton: UIButton!
    
    var comicManager = ComicManager()
    
    var selectedComic: Comic? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicManager.delegate = self
        
        if(selectedComic != nil) {
            let number = selectedComic?.comicNumber.replacingOccurrences(of: "#", with: "")
            comicManager.fetchComic(number: number!)
        }
    }
    
    @IBAction func deletePressedd(_ sender: Any) {
    
    }
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - ComicManagerDelegate - updating the view with the retrived data from the API

extension ComicDetailController: ComicManagerDelegate {
    
    func didUpdateComic(_ comicManager: ComicManager, comic: ComicModel) {
        DispatchQueue.main.async {
            self.comicTitleLabel.text  = comic.title
            self.comicNumberLabel.text = "#\(comic.num)"
            self.comicImageView.image = comic.img
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
