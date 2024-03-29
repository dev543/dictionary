//
//  Label+Extension.swift
//  multtiDataTable
//
//  Created by Hyperlink on 19/09/23.
//

import Foundation
import UIKit

extension UILabel{
    
    func customeTheme(){
        self.font = UIFont().customFont(AppMessages.fontRegular, 18)
        self.textColor = UIColor.white
    }
}
