//
//  ViewController.swift
//  backWordDataPass
//
//  Created by Hyperlink on 12/09/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    //MARK: - Outlates
    
    @IBOutlet weak var imageView        : UIImageView!
    @IBOutlet weak var txtName          : UITextField!
    @IBOutlet weak var txtEmail         : UITextField!
    @IBOutlet weak var txtSelectCategory: UITextField!
    @IBOutlet weak var txtDob           : UITextField!
    @IBOutlet weak var txtPhoneNumber   : UITextField!
    @IBOutlet weak var txtCode          : UITextField!
    @IBOutlet weak var textViewBio      : UITextView!
    @IBOutlet weak var viewPhoneNumber  : UIView!
    @IBOutlet weak var btnUpdate        : UIButton!
    @IBOutlet weak var btnDelete        : UIBarButtonItem!
    
    //-----------------------------------------
    
    //MARK: - Custom Variables
    
    var imagePicker            = UIImagePickerController()
    let datePicker             = UIDatePicker()
    let formatter              = DateFormatter()
    let pickerSelectCategory   = UIPickerView()
    let pickerCode             = UIPickerView()
    
    let arrCatagory : [String] = [ "Category 1","Category 2","Category 3",]
    let arrcode     : [String] = [ "+91","+92","+93",]
    
    var onClickClosuresModel : ((UserModel) -> () )?
    var onClickDeleteClosure : ((Int) -> () )?
    
    var imageVW = false
    var didTap  = false
    
    var updateUserModelData : UserModel?
    
    //-----------------------------------------
    
    //MARK: - Custom Methods
    
    func steupView() {
        
        self.applyTheme()
        self.setData()
        
        self.pickerSelectCategory.delegate         = self
        self.pickerSelectCategory.dataSource       = self
        
        self.pickerCode.delegate         = self
        self.pickerCode.dataSource       = self
        
        self.imagePicker.delegate        = self
        self.txtName.delegate            = self
        self.txtDob.delegate             = self
        self.txtEmail.delegate           = self
        self.txtCode.delegate            = self
        self.txtPhoneNumber.delegate     = self
        self.txtSelectCategory.delegate  = self
        self.textViewBio.delegate        = self
        
        self.txtCode.inputView           = self.pickerCode
        self.txtSelectCategory.inputView = self.pickerSelectCategory
        self.txtDob.inputView            = self.datePicker
        
        self.datePicker.preferredDatePickerStyle   = .wheels
        self.datePicker.datePickerMode             = .date
        
    }
    
    func applyTheme(){
        
        self.btnDelete.isEnabled                = false
        self.btnDelete.tintColor                = .clear
        self.txtPhoneNumber.textColor           = .white
        self.txtPhoneNumber.font                = UIFont().customFont(AppMessages.fontMedium, 16)
        self.txtCode.textColor                  = .white
        self.txtCode.font                       = UIFont().customFont(AppMessages.fontMedium, 16)
        self.viewPhoneNumber.layer.borderColor  = UIColor.white.cgColor
        self.viewPhoneNumber.layer.borderWidth  = 1
        self.viewPhoneNumber.layer.cornerRadius = 10
        self.txtCode.font                       = UIFont().customFont(AppMessages.fontRegular, 16.0)
//        self.txtCode.font?.customFont(AppMessages.fontRegular, 16.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        })
        
        self.imageView.layer.borderWidth = 2
        self.imageView.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: AppMessages.fontRegular, size: 18.0)!,NSAttributedString.Key.foregroundColor : UIColor.white]
        
        //        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        
        self.txtName.placeHolder(placeholder: AppMessages.fullName, font: UIFont().customFont(AppMessages.fontMedium, 14.0))
        self.txtDob.placeHolder(placeholder: AppMessages.dob, font: UIFont().customFont(AppMessages.fontMedium, 14.0))
        self.txtEmail.placeHolder(placeholder: AppMessages.email, font: UIFont().customFont(AppMessages.fontMedium, 14.0))
        self.txtSelectCategory.placeHolder(placeholder: AppMessages.category, font: UIFont().customFont(AppMessages.fontMedium, 14.0))
        self.txtCode.placeHolder(placeholder: AppMessages.code, font: UIFont().customFont(AppMessages.fontMedium, 14.0))
        self.txtPhoneNumber.placeHolder(placeholder: AppMessages.phoneNumber, font: UIFont().customFont(AppMessages.fontMedium, 14.0))
        
        
        self.textViewBio.text       = AppMessages.bio
        self.textViewBio.font       = UIFont().customFont(AppMessages.fontSemiBold, 14.0)
        self.textViewBio.textColor  = UIColor.gray
        
        self.txtName.setLeftView(image: UIImage(named: AppMessages.person) ?? UIImage())
        self.txtEmail.setLeftView(image: UIImage(named: AppMessages.imageMail) ?? UIImage())
        self.txtDob.setLeftView(image: UIImage(named: AppMessages.person) ?? UIImage())
        self.txtSelectCategory.setLeftView(image: UIImage(named: AppMessages.person) ?? UIImage())
        self.txtSelectCategory.setRightView(image: UIImage(named: AppMessages.drop) ?? UIImage())
        self.txtName.setRightView1()
        self.txtEmail.setRightView1()
        self.txtCode.setRightView(image: UIImage(named: AppMessages.drop) ?? UIImage())
        
        self.textViewBio.leftSpace()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.imageView.addGestureRecognizer(tap)
        
        self.datePicker.addTarget(self, action: #selector(self.setDate), for: .valueChanged)
        
    }
    
    func setData(){
        
        if  didTap == true {
            
            self.btnDelete.isEnabled = true
            self.btnDelete.tintColor = .white
            self.imageVW = true
            
            if let data = updateUserModelData {
                
                self.txtName.text           = data.name
                self.txtEmail.text          = data.email
                self.txtDob.text            = data.dob
                self.txtSelectCategory.text = data.category
                self.textViewBio.text       = data.bio
                self.imageView.image        = data.image
                self.txtPhoneNumber.text    = data.phoneNumber
                self.txtCode.text           = data.code
                
            }
            
            self.textViewBio.textColor  = .white
            self.btnUpdate.setTitle(AppMessages.update, for: .normal)
            self.navigationItem.title = AppMessages.editProfile
            
        }
    }
    
    @objc func setDate(){
        
        print("date")
        self.formatter.dateFormat   = AppMessages.dateFormate
        self.datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -53, to: Date())
        self.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        self.txtDob.text            = self.formatter.string(from: datePicker.date)
        
        //        if let date = formatter.string(from: datePicker.date){
        //            let components = Calendar.current.dateComponents([.day, .month], from: date)
        //            let day = components.day!
        //            let month = components.month!
        //
        //            print(day, month)
        //        }
        
        self.view.endEditing(true)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.openSheet()
    }
    
    //    //alertFunction
    //    func showalert(message : String){
    //        let alert = UIAlertController(title: "", message: message,preferredStyle: .alert)
    //        let aleartOk = UIAlertAction(title: "Ok", style: .default) {
    //            action in print("Ok")
    //        }
    //        alert.addAction(aleartOk)
    //        self.present(alert, animated: true)
    //    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            
            self.imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "", message: AppMessages.youDonthaveCamera, preferredStyle: .alert)
                let action = UIAlertAction(title: AppMessages.ok, style: .default)
                controller.addAction(action)
                return controller
                
            }()
            self.present(alertController, animated: true)
        }
    }
    
    func openGallery(){
        
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openSheet() {
        let alert = UIAlertController(title: AppMessages.chooseImage, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: AppMessages.cancel, style: .default){
            action in
            
            self.openCamera()
            
        }
        let galleryAction = UIAlertAction(title: AppMessages.photoLibrary, style: .default){
            action in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: AppMessages.cancel, style: .cancel){
            action in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    // validFunction
    func valid() -> String? {
        
        //        guard self.imageVW == true else{
        //            return AppMessages.emptyImage
        //        }
        //        guard !(self.txtName.text?.isEmpty)! else{
        //            return AppMessages.emptyFullName
        //        }
        //        guard !(self.txtCode.text?.isEmpty)! else{
        //            return AppMessages.emptyCode
        //        }
        //        guard !(self.txtPhoneNumber.text?.isEmpty)! else{
        //            return AppMessages.emptyPhone
        //        }
        //        guard self.txtPhoneNumber.text!.count == 10 else {
        //            return AppMessages.validPhoneNumber
        //        }
        //        
        //        guard !self.txtEmail.text!.isEmpty else{
        //            return AppMessages.emptyemail
        //        }
        //        guard self.txtEmail.isValidEmail(testStr: txtEmail.text ?? "") else{
        //            return AppMessages.validEmail
        //        }
        //        guard !self.txtSelectCategory.text!.isEmpty else{
        //            return AppMessages.emptySelect
        //        }
        //        guard !self.txtDob.text!.isEmpty else{
        //            return AppMessages.emptydob
        //        }
        //        guard self.textViewBio.text != AppMessages.bio && self.textViewBio.text != "" else
        //        {
        //            return AppMessages.emptybio
        //        }
        return nil
    }
    //----------------------------------------
    
    //MARK: - Actions
    
    @IBAction func btnAdd(_ sender: Any) {
        if let error = valid() {
            self.showalert(message: error)
        }else{
            
            if let userModelData = onClickClosuresModel{
                
                if let updateUserModelData = updateUserModelData {
                    let usermodelDetails = UserModel(self.txtName.text ?? "",
                                                     self.txtEmail.text ?? "",
                                                     self.txtDob.text ?? "",
                                                     self.txtSelectCategory.text ?? "",
                                                     self.textViewBio.text ?? "",
                                                     self.imageView.image ?? UIImage(),
                                                     self.txtPhoneNumber.text ?? "",
                                                     self.txtCode.text ?? "",
                                                     updateUserModelData.id)
                    
                    userModelData(usermodelDetails)
                }else{
                    
                    let usermodelDetails = UserModel(self.txtName.text ?? "",
                                                     self.txtEmail.text ?? "",
                                                     self.txtDob.text ?? "",
                                                     self.txtSelectCategory.text ?? "",
                                                     self.textViewBio.text ?? "",
                                                     self.imageView.image ?? UIImage(),
                                                     self.txtPhoneNumber.text ?? "",
                                                     self.txtCode.text ?? "")
                    
                    userModelData(usermodelDetails)
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: AppMessages.areSureWantToDelete,preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: AppMessages.cancel, style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: AppMessages.delete, style: .destructive) { [self] _ in
            
            if let deleteUser = onClickDeleteClosure{
                
                deleteUser(updateUserModelData?.id ?? 0)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true)
        
    }
    
    @IBAction  func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //----------------------------------------
    
    //MARK: - Lifecycle methods
    
    deinit {
        debugPrint("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.steupView()
        debugPrint("SecondScreenViewDidLoad")
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        debugPrint("SecondScreenViewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        debugPrint("SecondScreenViewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        debugPrint("SecondScreenViewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        debugPrint("SecondScreenViewDidDisappear")
    }

    
    //----------------------------------------
}

//MARK: - UIImagePickerControllerDelegate

extension ProfileVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] {
            self.imageView.image = image as? UIImage
        }
        self.imageVW = true
        self.imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        self.imagePicker.dismiss(animated: true)
    }
}

//MARK: - Textview delegate methos

extension  ProfileVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text      = ""
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text      = AppMessages.bio
            textView.textColor = UIColor.gray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.textViewBio == textView{
            if range.location == 0 && text == " "{
                return false
            }else if text == "\n"{
                return false
            }
        }
        return true
    }
}

//MARK: - UIPickerViewDelegate Methods
extension ProfileVC : UIPickerViewDelegate,UIPickerViewDataSource {
    
    @objc(numberOfComponentsInPickerView:) func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @objc func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrCatagory.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCode{
            return self.arrcode[row]
        }else{
            return self.arrCatagory[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickerCode{
            return  self.txtCode.text = self.arrcode[row]
        }else{
            return self.txtSelectCategory.text = self.arrCatagory[row]
        }
        //                self.view.endEditing(true)
    }
}

//MARK: - TextField delegate methos
extension ProfileVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
                return true
            }
        }
        
        if self.txtName == textField{
            if range.location == 0 && string == " "{
                return false
            }else if self.txtName.isValidFirstName(testStr: string) || string == " " {
                return true
            }else{
                return false
            }
        }
        
        if self.txtCode == textField{
            return false
        }
        
        if self.txtDob == textField{
            return false
        }
        
        if self.txtSelectCategory == textField{
            return false
        }
        
        if self.txtPhoneNumber == textField {
            if range.location <= 0 && string == " "{
                return false
            }else if self.txtPhoneNumber.text!.count <= 9 || string == " " {
                
                return self.txtPhoneNumber.isValidContectNo(testStr:string)
            }
            return false
            
        }
        debugPrint("shouldChangeCharactersIn")
        return true
    }
}

