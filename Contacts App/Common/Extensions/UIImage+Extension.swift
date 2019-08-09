//
//  UIImage+Extension.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

extension UIImage {
    func isEqualToImage(image: UIImage) -> Bool {
        return self.pngData() == image.pngData()
    }
}
