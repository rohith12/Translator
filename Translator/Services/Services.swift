
//
//  Services.swift
//  Translator
//
//  Created by Rohith Raju on 13/06/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Services {
    
   let baseUrl = "https://translation.googleapis.com"
   let translateUrl = "/language/translate/v2?key={AIzaSyCfuGXrN3DTkLRBuPkGPtWSvvtHhImqoJs}"
   
    func translateText(source: String, target: String, text: String,completion: @escaping ([String:String]) -> Void){
        

    let parameters: Parameters = ["key":"AIzaSyCfuGXrN3DTkLRBuPkGPtWSvvtHhImqoJs","q":text,"source":"en","target":target]

      Alamofire.request("https://translation.googleapis.com/language/translate/v2", method: .post, parameters: parameters).responseJSON { response in
        
        if response.result.isSuccess{
            
            let json = JSON(response.result.value!)
            let res = self.extractTranslatedText(dict: json)
            completion(["success": res])
            
        }else{
            print("error:\(String(describing: response.result.error.debugDescription))")
            completion(["error": String(describing: response.result.error.debugDescription)])

        }
        
        
      }
    
    }
    
    
    func extractTranslatedText(dict:JSON) -> String {
    
        let translations = dict["data"]["translations"]
        let translatedText = translations[0]["translatedText"].stringValue
        return translatedText
    }
    
}
