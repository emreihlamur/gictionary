//
//  ViewController.swift
//  alamofireDictionary
//
//  Created by Emre Ihlamur on 19/05/2017.
//  Copyright © 2017 Emre Ihlamur. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var tvResult: UITextView!
    @IBOutlet weak var tfFrom: UITextField!
    @IBOutlet weak var tfTo: UITextField!
    @IBOutlet weak var tfPhrase: UITextField!
    @IBOutlet weak var jsonData: UITextView!
    
    
    var anlamlar = [AnyObject]()
    
    @IBAction func change(_ sender: Any) {
        
    }
    @IBAction func btnTranslate(_ sender: Any) {
        let base  = "https://glosbe.com/gapi/translate?from=\(tfFrom.text!)&dest=\(tfTo.text!)&format=json&phrase=\(tfPhrase.text!)&pretty=true"
        let stringUrl = URL.init(string: base)
        
    
        
        if let url = stringUrl {
            let task = URLSession.shared.dataTask(with: url, completionHandler: {
                (data, response, error) in
                
                if(error == nil) {
                    if let usableData = data {
                        let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as! [String:Any]
                        if let tuc = json["tuc"] as! [Any]? {
                            var resultStr = ""
                            for element in 0..<tuc.count {
                                var obj = tuc[element] as! [String:Any]
                                if let phrase = obj["phrase"] as! [String:String]? {
                                    if let text = phrase["text"] {
                                        resultStr = "\(resultStr)\n\(text)"
                                    } else {}
                                } else {}
                            }
                            DispatchQueue.main.async(execute: {
                                self.tvResult.text = resultStr
                            })
                        } else{ //tuc boş
                        }
                    }else { //data boş nil
                    }
                } else{//error var
                }
            })
            task.resume()
        }
        else { //url yanlış
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

