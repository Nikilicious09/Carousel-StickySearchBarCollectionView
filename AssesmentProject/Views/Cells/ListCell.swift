//
//  ListCell.swift
//  AssesmentProject
//
//  Created by Nikil Vinod on 26/06/21.
//

import UIKit

class ListCell: UICollectionViewCell {

    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setDataSource(params: HPModel) {
        self.listName.text = params.name
        if let imageName = params.image, let imageURL = URL(string: imageName) {
            self.listImageView.loadImage(url: imageURL)
            self.listImageView.layer.cornerRadius = self.listImageView.bounds.width/2
        }
    }
    
}
