//
//  TextView+extension.swift
//  backWordDataPass
//
//  Created by Hyperlink on 12/09/23.
//

import Foundation
import UIKit

class theameView : UITextView {
    
    override func awakeFromNib() {
        
        self.layer.borderColor  = UIColor.white.cgColor
        self.layer.borderWidth  = 1
        self.layer.cornerRadius = 10
    }
}
