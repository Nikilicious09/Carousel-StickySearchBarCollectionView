//
//  Extensions.swift
//  AssesmentProject
//
//  Created by Nikil Vinod on 26/06/21.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(url: URL) {
        let imageDownloadQueue = DispatchQueue(label: "imagedownloadqueue")
        
        imageDownloadQueue.async {
            let cache = URLCache.shared
            if let imageData = cache.cachedResponse(for: URLRequest(url: url))?.data, let cachedImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
            } else {
                let imageData = try? Data(contentsOf: url)
                
                if let imageData = imageData {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
}

