//
//  ScannerViewController.swift
//  QRCode
//
//  Created by Sakthikumar on 1/7/18.
//  Copyright © 2018 Sakthikumar. All rights reserved.
//

import UIKit
import AVFoundation
import Contacts

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startReading()
        drawRectInCenter()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopReading()
    }
    
    func drawRectInCenter() {
        let radius = 100.0
        let path = UIBezierPath(roundedRect: CGRect(x: 0.0, y: 0.0,
                                                    width: self.view.bounds.size.width,
                                                    height: self.view.bounds.size.height),
                                                    cornerRadius: 0)
        let circlePath = UIBezierPath(roundedRect: CGRect(x: ((Double(view.frame.width) - (2.0*radius))/2),
                                                          y: ((Double(view.frame.height) - (2.0*radius))/2),
                                                          width: 2.0*radius, height: 2.0*radius),
                                                          cornerRadius: CGFloat(0))
        path.append(circlePath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = UIColor.white.cgColor
        fillLayer.opacity = 0.5
        view.layer.addSublayer(fillLayer)
    }
    
    func startReading() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
        } catch {
            print("Exception occured while reading: \(error.localizedDescription)")
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        print(captureMetadataOutput.availableMetadataObjectTypes)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession?.startRunning()
    }
    
    func stopReading() {
        captureSession?.stopRunning()
        captureSession = nil
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        for data in metadataObjects {
            let metaData = data as! AVMetadataObject
            print(metaData.description)
            let transformed = videoPreviewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                print("Read text: \(String(describing: unwraped.stringValue))")
            }
        }
    }
}

