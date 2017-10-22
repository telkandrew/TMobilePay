//
//  ViewController.swift
//  ScanNGo
//
//  Created by Eric Townsend on 10/21/17.
//  Copyright © 2017 TrapFi. All rights reserved.
//

import UIKit
import PopupDialog
import AVFoundation

class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var backView: UIView!

    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var product = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showFullProduct), name: NSNotification.Name.init(rawValue: "showProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startSession), name: NSNotification.Name.init(rawValue: "startSession"), object: nil)
        
        // Create a session object.
        session = AVCaptureSession()
        
        // Set the captureDevice.
        let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: videoCaptureDevice!)
            
            // Initialize the captureSession object.
            session = AVCaptureSession()
            session.addInput(input)
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            scanningNotPossible()
            return
        }
        
        // Create output object.
        let metadataOutput = AVCaptureMetadataOutput()
        
        // Add output to the session.
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
        } else {
            scanningNotPossible()
        }
        
        // Add previewLayer and have it show the video data.
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        backView.layer.addSublayer(previewLayer)
        
        let topImage = UIImageView(frame: CGRect(x: self.view.frame.width / 3, y: 20, width: 150.0, height: 50.0))
        topImage.image = #imageLiteral(resourceName: "t-mobile-full-logo")
        topImage.contentMode = .scaleAspectFit
        backView.addSubview(topImage)
        
        let menuButton = UIButton(frame: CGRect(x: 20.0, y: 23, width: 60.0, height: 40.0))
        menuButton.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        menuButton.setTitle("BACK", for: .normal)
        menuButton.setTitleColor(.white, for: .normal)
        backView.addSubview(menuButton)
        
        // Begin the capture session.
        
        session.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (session?.isRunning == false) {
            session.startRunning()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.isRunning == true) {
            session.stopRunning()
        }
    }
    
    @objc func back (_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func startSession() {
        session.startRunning()
    }

    
    func scanningNotPossible() {
        // Let the user know that scanning isn't possible with the current device.
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        session = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Get the first object from the metadataObjects array.
        if let barcodeData = metadataObjects.first {
            // Turn it into machine readable code
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject
            if let readableCode = barcodeReadable {
                // Send the barcode as a string to barcodeDetected()
                barcodeDetected(code: readableCode.stringValue!)
                
                // Vibrate the device to give the user some feedback.
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                // Avoid a very buzzy device.
                session.stopRunning()
            }
        }
    }
    
    @objc func showFullProduct() {
        guard product.productName != nil else {
            session.startRunning()
            return
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullDetailViewController") as! FullDetailViewController
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
        return
    }
    
    func barcodeDetected(code: String) {
        Networking().getItemFromUPC(code: code, completionHandler: { (finalProduct, error) in
            if finalProduct != nil && finalProduct?.productName != nil {
                self.product = finalProduct!
                
                // Do popupdialog
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuickDetailViewController") as! QuickDetailViewController
                vc.product = self.product
                let popup = PopupDialog(viewController: vc)
                popup.transitionStyle = .bounceUp
                
                let overlayAppearance = PopupDialogOverlayView.appearance()
                overlayAppearance.color  = UIColor.init(red: 199.0/255.0, green: 64.0/255.0, blue: 126.0/255.0, alpha: 1.0)
                
                self.present(popup, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Sorry", message: "We could not find a T-Mobile product that matches the barcode specified.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Thanks", style: .destructive, handler: nil)
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: {
                    self.session.startRunning()
                })
            }
        })
    }

}
