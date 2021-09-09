//
//  MeteorLandingTableViewCell.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 9/9/21.
//

import Foundation
import UIKit

class MeteorLandingTableViewCell: UITableViewCell {
    @IBOutlet weak var meteorName: UILabel!
    @IBOutlet weak var recclassName: UILabel!
    @IBOutlet weak var massSize: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func saveAsFavorite(_ sender: UIButton) {
        setFavoriteFunction?()
        favoriteButton.imageView?.image = favoriteButton.imageView?.image == UIImage(systemName: "star.fill") ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
    }
    
    var setFavoriteFunction: (()->())?
    
    func configure(_ meteorLanding: MeteorLanding, isFavorite: Bool = false) {
        meteorName.text = meteorLanding.name
        recclassName.text = meteorLanding.recclass
        massSize.text = meteorLanding.mass
        year.text = DateUtils.getYearFromDate(meteorLanding.year) ?? "--"
        favoriteButton.imageView?.image = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
}
