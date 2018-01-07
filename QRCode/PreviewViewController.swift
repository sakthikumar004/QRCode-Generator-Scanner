//
//  PreviewViewController.swift
//  QRCode
//
//  Created by Sakthikumar on 1/8/18.
//  Copyright © 2018 Sakthikumar. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let qrCodeImage = generateQRCode(from: text ?? "") {
            imageView.image = qrCodeImage
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            guard let qrCodeImage = filter.outputImage else { return nil }
            let scaleX = imageView.frame.size.width / qrCodeImage.extent.size.width
            let scaleY = imageView.frame.size.height / qrCodeImage.extent.size.height
            
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            if let output = filter.outputImage?.transformed(by: transform) {
                return convert(cmage: output)
            }
        }
        return nil
    }
    
    func convert(cmage:CIImage) -> UIImage {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}

