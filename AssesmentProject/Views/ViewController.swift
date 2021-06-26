//
//  ViewController.swift
//  AssesmentProject
//
//  Created by Nikil Vinod on 24/06/21.
//

import UIKit

enum SectionType: Int {
    case Carousel = 0, List
}

class ViewController: UIViewController {

    let searchCellIdentifier = "SearchView"
    let carouselCellIdentifier = "CarouselCell"
    let listCellIdentifier = "ListCell"
    static let carouselCollectionCellIdentifier = "CarouselCollectionViewCell"
    
    var currentTextString = ""

    var carousalData = [HPModel]()
    var hpcharList = [HPModel]()
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    fileprivate func setupListDataSource(param: String) {
        let url = Bundle.main.url(forResource: "HPSample", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        hpcharList = try! JSONDecoder().decode([HPModel].self, from: data)
        let temphpcharList = hpcharList
        
        if !param.isEmpty {
            hpcharList  = temphpcharList.filter { $0.name!.contains(param) }
        }
        
        currentTextString = param
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self

        self.mainCollectionView.register(UINib(nibName: listCellIdentifier, bundle: .main), forCellWithReuseIdentifier: listCellIdentifier)
        self.mainCollectionView.register(UINib(nibName: carouselCellIdentifier, bundle: .main), forCellWithReuseIdentifier: "CarouselCell")
        self.mainCollectionView.register(UINib(nibName: searchCellIdentifier, bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: searchCellIdentifier)
        
        if let layout = mainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        
        setupListDataSource(param: "")
        
        self.carousalData = hpcharList.filter{$0.isCarousalItem}
        
        self.mainCollectionView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: CollectionView Datasources
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == SectionType.Carousel.rawValue {
            return 1
        }
        
        return hpcharList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let searchCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: searchCellIdentifier, for: indexPath) as! SearchView
            
            searchCell.searchDelegate = self
            
            searchCell.searchBar.text = currentTextString

            return searchCell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let carouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselCellIdentifier, for: indexPath) as! CarouselCell
            carouselCell.setDataSource(params: self.carousalData)
            
            return carouselCell
        }
        let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellIdentifier, for: indexPath) as! ListCell
        listCell.setDataSource(params: hpcharList[indexPath.item])
        
        return listCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 300)
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
        return .zero
    }
}

extension ViewController: SearchDelegate {
    func searchBeginEditing(input: String) {
        self.setupListDataSource(param: input)
        self.mainCollectionView.reloadSections(IndexSet(integer: 1))
        self.mainCollectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
    }
}

extension ViewController {
    @objc func handleKeyboardWillShow(notification: Notification) {
        self.mainCollectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
    }
}

