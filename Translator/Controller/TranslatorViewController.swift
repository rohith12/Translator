//
//  TranslatorViewController.swift
//  Translator
//
//  Created by Rohith Raju on 13/06/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {

    @IBOutlet weak var languagePicker: UIPickerView!
    @IBOutlet weak var sourceTextfield: UITextField!
    var languagesModel: [String:String] = [String:String]()
    var languages = [String]()
    var services = Services()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var targetLanguageButtonOutlet: UIButton!
    @IBOutlet weak var translatedLabelResult: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePicker.isHidden = true
        translatedLabelResult.isHidden = true
    }

    //MARK: Button outlets

    @IBAction func targetLanguageSelectorAction(_ sender: Any) {
        
        languagesModel =  LanguagesAbbreviation().getModel()
        languages = Array(languagesModel.keys)
        languagePicker.reloadAllComponents()
        languagePicker.isHidden = false
        
    }
    
    @IBAction func TranslateAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        if fieldValidator(src: self.sourceTextfield.text, target: languagesModel[(targetLanguageButtonOutlet.titleLabel?.text)!]){
            
            services.translateText(source: "en", target: (languagesModel[(targetLanguageButtonOutlet.titleLabel?.text)!])!, text: (self.sourceTextfield.text!),completion: completionHandler)
            
        }
        
    }
    
    
    //MARK: Service delegates

    func completionHandler(value: [String:String]) {
        
        activityIndicator.stopAnimating()
        translatedLabelResult.isHidden = false

        if let success = value["success"]{
            
            self.translatedLabelResult.text = success
            
        }else{
            
            displayAlertView(msg: "\(String(describing: value["error"]))")
            

        }
        
    }
    
    //MARK: field validation
    
    func fieldValidator(src: String?, target: String?) -> Bool{
        
        
        guard src != nil else {
            
            displayAlertView(msg: "Please enter source text")
            return false
            
        }
        
        guard target != nil else {
            
            displayAlertView(msg: "Please select target language")
            return false
            
        }
        
        return true
    }
    
    
    func displayAlertView(msg: String){
        
       let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
       let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
       alert.addAction(okAction)
       present(alert, animated: true, completion: nil)
        
    }
    
}

extension TranslatorViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.targetLanguageButtonOutlet.setTitle("\(languages[row])", for: .normal)
        languagePicker.isHidden = true
    }
    
    
    
}
