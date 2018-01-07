//
//  HomeViewController.swift
//  QRCode
//
//  Created by Sakthikumar on 1/7/18.
//  Copyright © 2018 Sakthikumar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    @IBAction func actionOnScanner(sender: UIButton) {
        let scannerVC = storyboardInstance.instantiateViewController(withIdentifier: "ScannerViewController")
        navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    @IBAction func actionOnGenerator(sender: UIButton) {
        let generatorVC = storyboardInstance.instantiateViewController(withIdentifier: "GeneratorViewController")
        navigationController?.pushViewController(generatorVC, animated: true)
    }
}
