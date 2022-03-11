//
//  MoviesCollectionViewCell.swift
//  FilmSepeti
//
//  Created by Muhammed Sefa Biçer on 17.02.2022.
//

import UIKit

protocol MoviesCellCollectionViewProtocol {
    
    func sepeteEkle(indexpath: IndexPath)
}

class MoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePriceLabel: UILabel!
  
    //MARK: Vars
    var cellProtocol : MoviesCellCollectionViewProtocol?
    var indexPath: IndexPath?
    
    @IBAction func addToBasketButton(_ sender: Any) {
        
        cellProtocol?.sepeteEkle(indexpath: indexPath!)
        
    }
    
    
    
}
