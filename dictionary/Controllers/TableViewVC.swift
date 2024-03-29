//
//  ViewController.swift
//  multtiDataTable
//
//  Created by Hyperlink on 19/09/23.
//

import UIKit

class TableViewVC: UIViewController {
    
    //MARK: - Outlates
    
    @IBOutlet weak var tblTableView   : UITableView!
    @IBOutlet weak var txtSearchBar   : UITextField!
    @IBOutlet weak var btnCancel      : UIButton!
    @IBOutlet weak var lblNoDataFound : UILabel!
    @IBOutlet weak var btnAdd         : UIBarButtonItem!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var arrMain    : [SectionModel] = []
    var arrDisplay : [SectionModel] = []
    
    var row           = 0
    var idCount       = 1
    //    var sectionIndex  = 0
    //    var numberOfSections: Int = 1
    
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func steupView() {
        
        self.applyTheme()
        self.txtSearchBar.delegate   = self
        self.tblTableView.delegate   = self
        self.tblTableView.dataSource = self
        //        self.txtSearchBar.delegate   = self
    }
    
    func applyTheme() {
        
        self.btnAdd.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: AppMessages.fontMedium, size: 20.0)!,NSAttributedString.Key.foregroundColor : UIColor.white], for: UIControl.State.normal)
        
        self.lblNoDataFound.font      = UIFont().customFont(AppMessages.fontSemiBold, 25.0)
        self.lblNoDataFound.textColor = UIColor(named: AppMessages.white30)
        
        self.txtSearchBar.isHidden = true
        self.btnCancel.isHidden    = true
        
        self.btnCancel.layer.cornerRadius = 10.0
        self.btnCancel.titleLabel?.font   = UIFont.init(name: AppMessages.fontRegular, size: 18.0) ?? UIFont()
        
        let cellNib = UINib(nibName: AppMessages.profileXIB, bundle: nil)
        self.tblTableView.register(cellNib, forCellReuseIdentifier: AppMessages.tabelViewCellClass)
        
        let sectionCellNib = UINib(nibName: AppMessages.SectionXIB, bundle: nil)
        self.tblTableView.register(sectionCellNib, forCellReuseIdentifier: AppMessages.sectionTabelViewCell)
        
        self.txtSearchBar.placeHolder(placeholder: AppMessages.searchBar, font: UIFont().customFont(AppMessages.fontSemiBold, 18.0))
        
    }
    
    @objc func didTapDelete(_ sender: UIButton) {
        
        let rowIndex     = sender.tag % 1000
        let sectionIndex = sender.tag / 1000
        
        let alert = UIAlertController(title: "", message: AppMessages.areSureWantToDelete,preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: AppMessages.cancel, style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: AppMessages.delete, style: .destructive) { _ in
            
            if self.txtSearchBar.text!.isEmpty {
                //            self.arrMain.remove(at: sender.tag)
                self.arrMain[sectionIndex].sectionData.remove(at: rowIndex)
                
                if self.arrMain[sectionIndex].sectionData.count == 0 {
                    self.arrMain.remove(at: sectionIndex)
                    
                }
                
                self.arrDisplay = self.arrMain
                self.tblTableView.reloadData()
                
            }else{
                
                let id = self.arrDisplay[sectionIndex].sectionData[rowIndex].id
                
                for (section, element) in self.arrMain.enumerated() {
                    for (row, data) in element.sectionData.enumerated(){
                        if data.id == id{
                            
                            self.arrMain[section].sectionData.remove(at: row)
                            
                            if self.arrMain[section].sectionData.count == 0 {
                                self.arrMain.remove(at: section)
                                
                            }
                            
                            self.arrDisplay[sectionIndex].sectionData.remove(at: rowIndex)
                        }
                    }
                }
                
                self.tblTableView.reloadData()
                
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true)
    }
    
    @objc func didTapEdit(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: AppMessages.main, bundle: nil)
        let secondScreen = storyBoard.instantiateViewController(withIdentifier: AppMessages.profileVC) as? ProfileVC
        secondScreen?.didTap = true
        self.row = sender.tag
        
        let rowIndex     = sender.tag % 1000
        let sectionIndex = sender.tag / 1000
        
        if self.txtSearchBar.text!.isEmpty {
            secondScreen?.updateUserModelData = self.arrMain[sectionIndex].sectionData[rowIndex]
        }else{
            secondScreen?.updateUserModelData = self.arrDisplay[sectionIndex].sectionData[rowIndex]
        }
        
        secondScreen?.onClickClosuresModel = { userData in
            
            if self.txtSearchBar.text!.isEmpty {
                
                //old name B
                //new name A
                
                // updateData name change or not
                //if change true
                //check section A true
                // data append
                // remove old
                //check section A false
                // add section with updated data
                //if change false
                
                let sectionTitle = userData.name?.uppercased().prefix(1)
                
                if self.arrMain[sectionIndex].sectionName ?? "" == sectionTitle ?? ""{
                    
                    self.arrMain[sectionIndex].sectionData[rowIndex] = userData
                    
                    self.arrMain[sectionIndex].sectionData  = self.arrMain[sectionIndex].sectionData.sorted { $0.name ?? "" < $1.name ?? ""}
                    
                }else{
                    
                    if let index = self.arrMain.firstIndex(where: { $0.sectionName?.uppercased() ?? "" == sectionTitle ?? "" }){
                        
                        //add data
                        self.arrMain[index].sectionData.append(userData)
                        
                        //remove data
                        self.arrMain[sectionIndex].sectionData.remove(at: rowIndex)
                        
                        if self.arrMain[sectionIndex].sectionData.count == 0 {
                            self.arrMain.remove(at: sectionIndex)
                        }
                        
                        //sort data
                        //  self.arrMain[index].sectionData  = self.arrMain[index].sectionData.sorted { $0.name ?? "" < $1.name ?? ""}
                        
                        
                    }else{
                        
                        // add data
                        self.arrMain.append(SectionModel(String(sectionTitle ?? ""), [userData]))
                        
                        //remove data
                        self.arrMain[sectionIndex].sectionData.remove(at: rowIndex)
                        
                        if self.arrMain[sectionIndex].sectionData.count == 0 {
                            self.arrMain.remove(at: sectionIndex)
                        }
                        
                        //sort data
                        // self.arrMain = self.arrMain.sorted(by: { $0.sectionName ?? "" < $1.sectionName ?? "" } )
                        
                    }
                    
                    //                    for short in self.arrMain {
                    //
                    //                        let shortData = short.sectionData.sorted(by: {$0.name ?? "" < $1.name ?? ""})
                    //                        self.arrMain[sectionIndex].sectionData = shortData
                    //                    }
                    
                }
                self.arrDisplay = self.arrMain
                
                //                let searchData = self.arrMain.flatMap({$0.sectionData}).filter { $0.name!.lowercased().contains(self.txtSearchBar.text!.lowercased())}
                //                self.arrDisplay.append(SectionModel("", searchData))
                
                self.tblTableView.reloadData()
                
            }else{
                
                let id = self.arrDisplay[sectionIndex].sectionData[rowIndex].id
                
                for (sectionMain, element) in self.arrMain.enumerated() {
                    for (rowMain, data) in element.sectionData.enumerated(){
                        
                        if data.id == id{
                            
                            self.arrMain[sectionMain].sectionData.remove(at: rowMain)
                            
                            if self.arrMain[sectionMain].sectionData.count == 0 {
                                self.arrMain.remove(at: sectionMain)
                                
                            }
                        }
                    }
                }
                
                let sectionTitle = userData.name?.uppercased().prefix(1)
                
                if let index = self.arrMain.firstIndex(where: {$0.sectionName?.uppercased() ?? "" == sectionTitle ?? ""}){
                    
                    self.arrMain[index].sectionData.append(userData)
                    //sort
                    self.arrMain[index].sectionData  = self.arrMain[index].sectionData.sorted { $0.name ?? "" < $1.name ?? ""}
                    
                }else{
                    
                    self.arrMain.append(SectionModel(String(sectionTitle ?? ""), [userData]))
                    //sort
                    self.arrMain = self.arrMain.sorted(by: { $0.sectionName ?? "" < $1.sectionName ?? "" } )
                }
                
                //  let searchData = self.arrMain.flatMap({$0.sectionData}).filter { $0.name!.lowercased().contains(self.txtSearchBar.text!.lowercased())}
                
                let searchData = self.arrMain.flatMap({$0.sectionData}).filter { $0.name!.lowercased().hasPrefix(self.txtSearchBar.text!.lowercased())}
                
                self.arrDisplay.removeAll()
                self.arrDisplay.append(SectionModel("", searchData))
                
                //  self.arrDisplay = self.arrMain
                
                self.tblTableView.reloadData()
                
            }
            
        }
        
        secondScreen?.onClickDeleteClosure = { userData in
            
            if self.txtSearchBar.text!.isEmpty {
                
                self.arrMain[sectionIndex].sectionData.remove(at: rowIndex)
                
                if self.arrMain[sectionIndex].sectionData.count == 0 {
                    self.arrMain.remove(at: sectionIndex)
                    
                }
                
                self.arrDisplay = self.arrMain
                self.tblTableView.reloadData()
                
            }else{
                
                let id = self.arrDisplay[sectionIndex].sectionData[rowIndex].id
                
                for (section, element) in self.arrMain.enumerated() {
                    for (row, data) in element.sectionData.enumerated(){
                        if data.id == id{
                            
                            self.arrMain[section].sectionData.remove(at: row)
                            
                            if self.arrMain[section].sectionData.count == 0 {
                                self.arrMain.remove(at: section)
                                
                            }
                            
                            self.arrDisplay[sectionIndex].sectionData.remove(at: rowIndex)
                        }
                    }
                }
                
                self.tblTableView.reloadData()
                
            }
        }
        self.navigationController?.pushViewController(secondScreen!, animated: true)
        
    }
    //----------------------------------------
    
    //MARK: - Actions
    
    @IBAction  func btnAdd(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: AppMessages.main, bundle: nil)
        let secondScreen = storyBoard.instantiateViewController(withIdentifier: AppMessages.profileVC) as? ProfileVC
        
        secondScreen?.onClickClosuresModel = { [self] userData in
            userData.id = self.idCount
            self.idCount += 1
            
            let sectionTitle = userData.name?.uppercased().prefix(1)
            
            if let index = self.arrMain.firstIndex(where: {$0.sectionName?.uppercased() ?? "" == sectionTitle ?? ""}){
                
                self.arrMain[index].sectionData.append(userData)
                
                self.arrMain[index].sectionData  = self.arrMain[index].sectionData.sorted { $0.name ?? "" < $1.name ?? ""}
                
            }else{
                
                self.arrMain.append(SectionModel(String(sectionTitle ?? ""), [userData]))
                
                self.arrMain = self.arrMain.sorted(by: { $0.sectionName ?? "" < $1.sectionName ?? "" } )
                
            }
            
            if self.txtSearchBar.text!.isEmpty {
                
                self.arrDisplay = self.arrMain
                
            }else{
                
                let searchData = self.arrMain.flatMap({$0.sectionData}).filter { $0.name!.lowercased().hasPrefix(self.txtSearchBar.text!.lowercased())}
                
                self.arrDisplay.removeAll()
                self.arrDisplay.append(SectionModel("", searchData))
                
            }
            
            self.tblTableView.reloadData()
        }
        
        self.navigationController?.pushViewController(secondScreen!, animated: true)
    }
    @IBAction func btnCancelClicked(_ sender: Any){
        
        self.txtSearchBar.text = ""
        
    }
    //----------------------------------------
    
    //MARK: - Lifecycle methods
    
    deinit {
        debugPrint("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.steupView()
        debugPrint("FirstScreenViewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("FirstScreenViewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("FirstScreenViewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        debugPrint("FirstScreenViewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        debugPrint("FirstScreenViewDidDisappear")
    }
    
    //----------------------------------------
}

//MARK: - UITableViewDelegate, UITableViewDataSource delegate methods

extension TableViewVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrDisplay[section].sectionData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let objSectionCell = tableView.dequeueReusableCell(withIdentifier: AppMessages.sectionTabelViewCell) as! SectionTabelViewCell
        
        let sectionData = arrDisplay[section]
        objSectionCell.confingSectionModel(sectionData)
        return objSectionCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if  self.arrDisplay.count == 0 {
            
            self.lblNoDataFound.isHidden = false
            self.txtSearchBar.isHidden   = true
            self.btnCancel.isHidden      = true
            
        }else{
            
            self.lblNoDataFound.isHidden = false
            self.txtSearchBar.isHidden   = false
            self.btnCancel.isHidden      = false
            
        }
        return self.arrDisplay.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let objCell = tableView.dequeueReusableCell(withIdentifier: AppMessages.tabelViewCellClass, for: indexPath) as! TabelViewCellClass
        let userData = arrDisplay[indexPath.section].sectionData[indexPath.row]
        objCell.confingModel(userData)
        
        objCell.btnEdit.tag = indexPath.row
        objCell.btnEdit.tag = (indexPath.section * 1000) + indexPath.row
        objCell.btnEdit.addTarget(self, action: #selector(didTapEdit(_:)), for: .touchUpInside)
        
        //        objCell.btnDelete.tag = indexPath.row
        
        objCell.btnDelete.tag = (indexPath.section * 1000) + indexPath.row
        objCell.btnDelete.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        
        self.lblNoDataFound.isHidden = true
        self.txtSearchBar.isHidden   = false
        self.btnCancel.isHidden      = false
        
        return objCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.txtSearchBar.text?.isEmpty == true {
            return 40
        }else{
            return 0.0
        }
        
    }
    
}

//MARK: - TextField delegate methods

extension TableViewVC : UITextFieldDelegate {
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        
        if textField == txtSearchBar {
            
            if ((self.txtSearchBar.text?.isEmpty) == true) {
                
                self.arrDisplay = self.arrMain
                self.tblTableView.reloadData()
                
            }else{
                
                //                self.arrMain.forEach { item in
                //                    item.sectionData
                //                }
                
                let searchData = self.arrMain.flatMap({$0.sectionData}).filter { $0.name!.lowercased().hasPrefix(self.txtSearchBar.text!.lowercased())}
                
                self.arrDisplay.removeAll()
                self.arrDisplay.append(SectionModel("", searchData))
                self.tblTableView.reloadData()
                print(searchData)
            }
        }
        
    }
}

