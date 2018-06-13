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
    @IBOutlet weak var targetLanguageButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePicker.isHidden = true
    }

   
    
    //MARK: Button outlets

    @IBAction func targetLanguageSelectorAction(_ sender: Any) {
        
        languagesModel =  LanguagesAbbreviation().getModel()
        languages = Array(languagesModel.keys)
        languagePicker.reloadAllComponents()
        languagePicker.isHidden = false
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
