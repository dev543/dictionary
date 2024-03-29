//
//  Alert+Extension.swift
//  dictionary
//
//  Created by Hyperlink on 05/10/23.
//

import Foundation
import UIKit

extension UIViewController {
    //alertFunction
    func showalert(message : String){
        let alert = UIAlertController(title: "", message: message,preferredStyle: .alert)
        let aleartOk = UIAlertAction(title: "Ok", style: .default) {
            action in print("Ok")
        }
        alert.addAction(aleartOk)
        self.present(alert, animated: true)
    }
    
//    func showAlertDelete(message : String){
//        let alert = UIAlertController(title: "are you sure want to delete", message: message,preferredStyle: .alert)
//        let aleartOk = UIAlertAction(title: "Ok", style: .destructive) {
//            action in print("Ok")
//        }
//        alert.addAction(aleartOk)
//        self.present(alert, animated: true)
//    }
    
    func showDeleteAlert(){
        
        let alert = UIAlertController(title: "", message: "Are Sure Want To Delete",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
          
//                self.namesArray.remove(at: indexPath.row)
//                self.imagesArray.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    
    //-------------------------------------
}

