//
//  CategoryTableViewCell.swift
//  FilmSepeti
//
//  Created by Muhammed Sefa Biçer on 17.02.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
