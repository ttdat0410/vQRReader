//
//  HospitalQR.swift
//  vQRScanner
//
//  Created by DatTran on 5/16/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import AVFoundation
import UIKit

class QRScanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    struct PassData {
        
        static var totalData: String = ""
        
    }
    
    private var objCaptureSession: AVCaptureSession?
    
    private var objCaptureVideoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    private var vwQRCode: UIView?
    
    let line: UIView = {
    
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.redColor()
        
        return v
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        navigationItem.title = "QRScanner"
        
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initQRView()
        
        self.setupLeftController()
        
        self.setupRightController()
        
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    override func viewDidAppear(animated: Bool) {
        
        objCaptureSession?.startRunning()
        
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        objCaptureSession?.stopRunning()
        
    }
    
    func setupLeftController() {
        
        let close = UIBarButtonItem(image: UIImage(named: "ic_close_25"), style: .Plain, target: self, action: #selector(handleClose))
        navigationItem.leftBarButtonItem = close
    }
    
    func setupRightController() {
        
        let flash = UIBarButtonItem(image: UIImage(named: "ic_flash_off_27"), style: .Plain, target: self, action: #selector(handleFlash))
        
        navigationItem.rightBarButtonItems = [flash]
        
    }
    
    func configureVideoCapture() {
        
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error: NSError?
        
        let objCaptureDeviceInput: AnyObject!
        
        do {
            
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice)
                as AVCaptureDeviceInput
            
            
        } catch let err as NSError {
            error = err
            objCaptureDeviceInput = nil
        }
        
        if (error != nil) {
            
            let alert: UIAlertController = UIAlertController(title: "Lỗi", message: "Thiết bị không được hỗ trợ!", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
//            navigationController?.pushViewController(DetailTBController(), animated: true)

            
            return
            
        }
        
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
    }
    
    func addVideoPreviewLayer() {
        
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
        //        self.view.bringSubviewToFront(la)
        //        self.view.bringSubviewToFront("")
        
        
    }
    
    func initQRView() {
        
        view.addSubview(line)
        view.addConstrainsWithFormat("H:|-10-[v0]-10-|", views: line)
        view.addConstrainsWithFormat("V:[v0(1.5)]", views: line)
        
        view.addConstraint(NSLayoutConstraint(item: line, attribute: .CenterY, relatedBy: .Equal, toItem: view.self, attribute: .CenterY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: line, attribute: .CenterX, relatedBy: .Equal, toItem: view.self, attribute: .CenterX, multiplier: 1, constant: 0))
        
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.whiteColor().CGColor
        vwQRCode?.layer.borderWidth = 2.0
        self.view.addSubview(vwQRCode!)
        self.view.bringSubviewToFront(vwQRCode!)
        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCode?.frame = CGRectZero
            // CASE: CANNOT READ
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                
                objCaptureSession?.stopRunning()
                
                QRScanner.PassData.totalData = "\(objMetadataMachineReadableCodeObject.stringValue)"
                
                if (HomeController.PassData.Mode == "HOSPITAL") {
                    navigationController?.pushViewController(DetailTBController(), animated: true)
                } else if (HomeController.PassData.Mode == "OTHER") {
                    navigationController?.pushViewController(Information(), animated: true)

                }
            }
        }
    }
    
    
    
    func handleClose () {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    var isFlash = false
    func handleFlash(sender: UIBarButtonItem) {
        
        isFlash = !isFlash
        
        if (isFlash) {
        
            sender.image = UIImage(named: "ic_flash_on_27")
            
        } else {
            
            sender.image = UIImage(named: "ic_flash_off_27")

        }
        
    }
    
}