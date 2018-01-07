//
//  GeneratorViewController.swift
//  QRCode
//
//  Created by Sakthikumar on 1/7/18.
//  Copyright © 2018 Sakthikumar. All rights reserved.
//

import UIKit

class GeneratorViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var generateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = #colorLiteral(red: 0.5791940689, green: 0.2943384585, blue: 0.5726861358, alpha: 1).cgColor
        textView.layer.borderWidth = 1.0
    }
    
    @IBAction func actionOnGenerate(sender: UIButton) {
        guard !textView.text.isEmpty else {
            print("Please enter text to generate QRCode")
            return
        }
        
        let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
        let previewVC = storyboardInstance.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        previewVC.text = textView.text
        navigationController?.pushViewController(previewVC, animated: true)
    }
}
