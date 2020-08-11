//
//  Image.swift
//  Reciplease
//
//  Created by rochdi ben abdeljelil on 10.08.2020.
//  Copyright © 2020 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK: - Properties
    
    /// Load url on UIImageview
    func load(url: URL) {
        guard let data = try? Data(contentsOf: url) else {return}
        guard let image = UIImage(data: data) else {return}
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
