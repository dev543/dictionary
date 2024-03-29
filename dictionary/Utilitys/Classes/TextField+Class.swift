//
//  TextField+Class.swift
//  backWordDataPass
//
//  Created by Hyperlink on 12/09/23.
//

import Foundation
import UIKit

class TextFieldTheme : UITextField {
    
    override func awakeFromNib() {
        
        self.textColor            = UIColor.white
        self.layer.borderColor    = UIColor.white.cgColor
        self.font                 = UIFont(name: AppMessages.fontMedium, size: 16)
        self.layer.borderWidth    = 1
        self.layer.cornerRadius   = 10
    }
    
}
