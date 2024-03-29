//
//  Button+Class.swift
//  backWordDataPass
//
//  Created by Hyperlink on 12/09/23.
//

import Foundation
import UIKit

class ButtonTheme : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setTitleColor(UIColor.black, for: .normal)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.titleLabel?.font = UIFont.init(name: AppMessages.fontSemiBold, size: 15) ?? UIFont()
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        self.layer.shadowOpacity = 1
//        self.layer.shadowRadius  = 4
    }
}
