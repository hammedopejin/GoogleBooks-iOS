//
//  DownloadService.swift
//  GoogleBooks
//
//  Created by Hammed opejin on 5/11/19.
//  Copyright © 2019 Hammed opejin. All rights reserved.
//

import UIKit

typealias bookHandler = ([Book]?) -> Void
typealias imageHandler = (UIImage?) -> Void
let DLService = DownloadService.shared

final class DownloadService {
    
    private init(){}
    static let shared = DownloadService()
    let cache = NSCache<NSString, UIImage>()
    
    func downloadImage(url: String, completion: @escaping imageHandler) {
        
        if let image = cache.object(forKey: url as NSString) {
            completion(image)
            return
        }
        
        guard let imageUrl = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [unowned self] (data, _, err) in
            
            if let error = err {
                print("Couldn't retrieve data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
            if let data = data {
                
                guard let image = UIImage(data: data) else{
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                self.cache.setObject(image, forKey: url as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
        }.resume()
        
    }
  
}
