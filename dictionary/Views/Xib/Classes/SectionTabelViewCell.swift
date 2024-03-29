//
//  SectionTabelViewCell.swift
//  dictionary
//
//  Created by Hyperlink on 05/10/23.
//

import UIKit

class SectionTabelViewCell: UITableViewCell {

    //MARK: - Outlates
  
    @IBOutlet weak var lblSection  : UILabel!
    
    @IBOutlet weak var tblCellSection: UIView!
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func steupView() {
        self.applyTheme()
    }
    
    func applyTheme() {
        
    
    }
    
    //Confing ModelClass Function
    
    func confingSectionModel(_ sectionModel : SectionModel){

        self.lblSection.text    = sectionModel.sectionName
        
    }
    //----------------------------------------
    
    //MARK: - Actions
    
    //----------------------------------------
    
    //MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.steupView()
    }
    //----------------------------------------
    

}
