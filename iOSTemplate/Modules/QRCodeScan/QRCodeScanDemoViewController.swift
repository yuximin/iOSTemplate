//
//  QRCodeScanDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/10/17.
//

import UIKit
import AVFoundation

class QRCodeScanDemoViewController: UIViewController {
    
    private lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        return session
    }()
    
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(scanButton)
        scanButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Method
    
    private func doScan() {
        guard let device = AVCaptureDevice.default(for: .video),
              let deviceInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if let inputs = captureSession.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                captureSession.removeInput(input)
            }
        }
        
        if let outputs = captureSession.outputs as? [AVCaptureMetadataOutput] {
            for output in outputs {
                captureSession.removeOutput(output)
            }
        }
        
        captureSession.addInput(deviceInput)
        captureSession.addOutput(metadataOutput)
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
        
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        videoPreviewLayer.backgroundColor = UIColor.red.withAlphaComponent(0.2).cgColor
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = self.view.bounds
        self.view.layer.addSublayer(videoPreviewLayer)
        
//        metadataOutput.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.8, height: 0.8)
    }
    
    // MARK: - Action
    
    @objc private func didTapScan(_ sender: UIButton) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    // 已授权
                    self.doScan()
                } else {
                    // 未授权
                }
            }
        }
    }
    
    // MARK: - View
    
    private lazy var scanButton: UIButton = {
        let button = UIButton()
        button.setTitle("扫描二维码", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        button.addTarget(self, action: #selector(didTapScan(_:)), for: .touchUpInside)
        return button
    }()
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRCodeScanDemoViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.isEmpty {
            return
        }
        
        let metadataObject = metadataObjects[0]
        print(metadataObject)
    }
}
