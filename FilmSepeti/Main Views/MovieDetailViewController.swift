//
//  MovieDetailViewController.swift
//  FilmSepeti
//
//  Created by Muhammed Sefa Biçer on 17.02.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    //MARK: Vars
    var movie: Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if let f = movie {
            
            if let url = URL(string: "\(kIMAGELINK)\(f.film_resim!)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data!)
                    }
                }
            }
            
            movieNameLabel.text = f.film_ad
            yearLabel.text = f.film_yil
            categoryLabel.text = f.kategori?.kategori_ad
            directorLabel.text = f.yonetmen?.yonetmen_ad
        }
    }
}
