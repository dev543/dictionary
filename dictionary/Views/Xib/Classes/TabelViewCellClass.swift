//
//  TabelViewCell+Class.swift
//  searchBar
//
//  Created by Hyperlink on 29/09/23.
//

import UIKit

class TabelViewCellClass: UITableViewCell {

    //MARK: - Outlates
    
    @IBOutlet weak var imgView         : UIImageView!
    @IBOutlet weak var lblName         : UILabel!
    @IBOutlet weak var lblPhoneNumber  : UILabel!
    @IBOutlet weak var lblemail        : UILabel!
    @IBOutlet weak var lblDob          : UILabel!
    @IBOutlet weak var lblBio          : UILabel!
    @IBOutlet weak var btnEdit         : UIButton!
    @IBOutlet weak var btnDelete       : UIButton!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func steupView() {
        self.applyTheme()
    }
    
    func applyTheme() {
        
        self.lblName.font        = UIFont().customFont(AppMessages.fontRegular, 18)
        self.lblPhoneNumber.font = UIFont().customFont(AppMessages.fontRegular, 18)
        self.lblemail.font       = UIFont().customFont(AppMessages.fontRegular, 18)
        self.lblDob.font         = UIFont().customFont(AppMessages.fontRegular, 18)
        self.lblBio.font         = UIFont().customFont(AppMessages.fontRegular, 18)
        
        self.imgView.layer.borderWidth = 2
        self.imgView.layer.borderColor = UIColor.white.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.imgView.layer.cornerRadius = self.imgView.frame.width / 2
        })

    }
    
    //Confing ModelClass Function
    func confingModel(_ userModel : UserModel){

        self.lblName.text        = userModel.name
        self.lblemail.text       = userModel.email
        self.lblDob.text         = userModel.dob
        self.lblBio.text         = userModel.bio
        self.imgView.image       = userModel.image
        self.lblPhoneNumber.text = "\((userModel.code ?? "")) - " + "\((userModel.phoneNumber ?? ""))"
//        let date                 = userModel.dob! as NSString
//        self.lblDob.text         = date.substring(with: NSRange(location: 0, length: date.length > 8 ? 8 : date.length))
        
//        let date = Date()
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day,.month], from: date)
//        let month = components.month
//        let day   = components.day
        
        let date                = userModel.dob ?? ""
        let dateFormate         = DateFormatter()
        dateFormate.dateFormat  = "dd MMMM, yyyy"
        let dateObj             = dateFormate.date(from: date) ?? Date()
        dateFormate.dateFormat  = "dd - MMMM"
        self.lblDob.text        =  dateFormate.string(from: dateObj)
      
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
