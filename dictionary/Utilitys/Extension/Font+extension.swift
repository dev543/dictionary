//
//  Font+extension.swift
//  backWordDataPass
//
//  Created by Hyperlink on 12/09/23.
//

import Foundation
import UIKit

extension UIFont {
    
    func customFont(_ name: String,_ size: CGFloat) -> UIFont {
        return  UIFont(name: name, size: size) ?? UIFont()
    }
}
