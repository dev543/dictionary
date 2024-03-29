//
//  TextFild+Extention.swift
//  backWordDataPass
//
//  Created by Hyperlink on 12/09/23.
//

import Foundation
import UIKit

extension UITextField {

        //placeholder Function
        func placeHolder(placeholder : String,font : UIFont){
            attributedPlaceholder  = NSAttributedString(
                string: placeholder,attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: AppMessages.white30) ?? UIColor()])
        }
       
      //Regex
       func isValidFirstName(testStr:String) -> Bool {
           print("validate FirstName: \(testStr)")
           let FirstName = "[A-Za-z]+"
           let FirstNameTest = NSPredicate(format:"SELF MATCHES %@",FirstName)
           let result = FirstNameTest.evaluate(with: testStr)
           return result
       }
              
       func isValidContectNo(testStr:String) -> Bool {
           print("validate ContactNumber: \(testStr)")
           let Contect = "[0-9]+"
           let ContectTest = NSPredicate(format:"SELF MATCHES %@",Contect)
           let result = ContectTest.evaluate(with: testStr)
           return result
       }
       
       func isValidEmail(testStr:String) -> Bool {
           print("validate emilId: \(testStr)")
           let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@",emailRegEx)
           let result = emailTest.evaluate(with: testStr)
           return result
       }
       
       func isValidBio(testStr:String) -> Bool {
           print("validate Bio: \(testStr)")
           let Bio = "[A-Za-z0-9]{1,200}"
           let BioTest = NSPredicate(format:"SELF MATCHES %@",Bio)
           let result = BioTest.evaluate(with: testStr)
           return result
       }
    
     //Padding
    
      func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 12, y: 10, width: 25, height: 25))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 45))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
      }
    
    func setRightView(image: UIImage) {
      let iconView = UIImageView(frame: CGRect(x: 12, y: 10, width: 25, height: 25))
      iconView.image = image
      iconView.isUserInteractionEnabled = false
      let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
      iconContainerView.addSubview(iconView)
      iconContainerView.isUserInteractionEnabled = false
      rightView = iconContainerView
      rightViewMode = .always
    
    }
    
    func setRightView1() {
      let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
      rightView = iconContainerView
      rightViewMode = .always
    
    }
}
