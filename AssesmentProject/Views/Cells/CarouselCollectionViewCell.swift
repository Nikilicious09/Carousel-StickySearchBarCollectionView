//
//  CarouselCollectionViewCell.swift
//  AssesmentProject
//
//  Created by Nikil Vinod on 26/06/21.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCoursalView(param: HPModel) {
        if let image = param.image, let imageURL = URL(string: image) {
            imageView.loadImage(url: imageURL)
            imageView.contentMode = .scaleAspectFill
        }
    }

}
