//
//  CarouselCell.swift
//  AssesmentProject
//
//  Created by Nikil Vinod on 26/06/21.
//

import UIKit

class CarouselCell: UICollectionViewCell {

    @IBOutlet weak var pagerIndicator: UIPageControl!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var hpData = [HPModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainCollectionView.register(UINib(nibName: "CarouselCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        // Initialization code
    }
    
    
    
    func setDataSource(params: [HPModel]) {
        hpData = params
        self.mainCollectionView.reloadData()
    }
    
}

extension CarouselCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let carouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.carouselCollectionCellIdentifier, for: indexPath) as! CarouselCollectionViewCell
        carouselCell.setCoursalView(param: hpData[indexPath.item])
        
        return carouselCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pagerIndicator.currentPage = indexPath.item
    }
}
