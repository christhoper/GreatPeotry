//
//  ScanPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 01/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit
import AVFoundation


class ScanPageViewController: UIViewController {

    var output: ScanPageViewOutput!
    private let bag = DisposeBag()
    /// 扫描会话
    var session = AVCaptureSession()
    var videoInput: AVCaptureDeviceInput?
    var timer : Timer?
    
    var scanZoneViewWidth: CGFloat {
        GPConstant.width - 120
    }
    
    var scanZoneViewCenterY: CGFloat {
        GPConstant.height * 0.5
    }
    
    var leftTopPoint: CGPoint {
         CGPoint(x: (GPConstant.width - scanZoneViewWidth)/2, y: (scanZoneViewCenterY - (scanZoneViewWidth/2)))
    }
    
    var rightTopPoint: CGPoint {
        CGPoint(x: (GPConstant.width + scanZoneViewWidth)/2, y: (scanZoneViewCenterY - (scanZoneViewWidth/2)))
    }
    
    var leftBottomPoint: CGPoint {
        CGPoint(x: (GPConstant.width - scanZoneViewWidth)/2, y: (scanZoneViewCenterY + (scanZoneViewWidth/2)))
    }
    
    var rightBottomPoint: CGPoint {
        CGPoint(x: (GPConstant.width + scanZoneViewWidth)/2, y: (scanZoneViewCenterY + (scanZoneViewWidth/2)))
    }
    
    lazy var scanResultLabel: UILabel = {
        let label = UILabel()
        label.defaultConfigure()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var scanLineView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_line()
        return imageView
    }()
    
    lazy var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_main_back(), for: .normal)
        button.rx.tap.subscribe { (_) in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
        return button
    }()
    
    lazy var scanZoneView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    lazy var leftTopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_leftTop()
        return imageView
    }()
    
    lazy var rightTopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_rightTop()
        return imageView
    }()
    
    lazy var leftBottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_leftBottom()
        return imageView
    }()
    
    lazy var rightBottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_rightBottom()
        return imageView
    }()
    
    lazy var lampBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_scan_lamp(), for: .normal)
        button.setTitle("打开", for: .normal)
        button.rx.tap.subscribe { (_) in
            self.flashClick()
        }.disposed(by: bag)
        return button
    }()
    
    /// 预览图层
    lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
        preview.frame = CGRect(x: 0, y: 0, width: GPConstant.width, height:GPConstant.height)
        preview.backgroundColor = UIColor.black.cgColor

        return preview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavView()
        setupSubViews()
        addObserverForNoti()

        setupSesstion()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopRunning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationHidden(for: true)
        checkCameraStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationHidden(for: false)
        stopRunning()
    }
    
    deinit {
        print("释放了")
    }
}


extension ScanPageViewController {
    func addObserverForNoti() {}
    
    func setupNavView() {}
    
    func setupSubViews(){
        view.backgroundColor = UIColor.gray51
        view.addSubview(backBtn)
        view.addSubview(scanZoneView)
        scanZoneView.addSubview(leftTopImageView)
        scanZoneView.addSubview(rightTopImageView)
        scanZoneView.addSubview(leftBottomImageView)
        scanZoneView.addSubview(rightBottomImageView)
        view.addSubview(scanLineView)
        view.addSubview(lampBtn)
        view.addSubview(scanResultLabel)
        
        setupSubviewContraints()
    }
    
    private func setupSubviewContraints() {
        scanZoneView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(scanZoneViewWidth)
        }
        
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(GPConstant.kNavigationBarHeight/2 + GPConstant.kToolBarHeight)
        }
        
        leftTopImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(-1.5)
            make.left.equalToSuperview().inset(-2)
        }
        
        rightTopImageView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(-1.5)
        }
        
        leftBottomImageView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(-1.5)
            make.left.equalToSuperview().inset(-2)
        }
        
        rightBottomImageView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().inset(-1.5)
        }
        
        lampBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(scanZoneView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        lampBtn.setupButtomImage_LabelStyle(style: .imageUpLabelDown, imageTitleSpace: 5)
        lampBtn.layoutIfNeeded()
        
        scanResultLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(scanZoneView.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.left.equalTo(scanZoneView)
        }
    }
    
    private func checkCameraStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            startRunning()
        case .denied:
            fallthrough
        case .restricted:
            KRProgressHUD.showError(withMessage: "用户拒绝使用相机")
        case .notDetermined:
            KRProgressHUD.showError(withMessage: "用户还未同意或者拒绝")
            AVCaptureDevice.requestAccess(for: .video) { (granted: Bool) in
                DispatchQueue.main.async {
                    if granted {
                        self.startRunning()
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        default:
            break
        }
    }
    
    private func setupSesstion() {
        /// 获取设备
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        let device = deviceDiscoverySession.devices.filter({ $0.position == .back }).first
        guard let dev = device else { return }
        /// 视频输入
        let videoInput = try? AVCaptureDeviceInput(device: dev)
        let queue =  DispatchQueue.global(qos: .default)
        let videoOutput = AVCaptureMetadataOutput()
        videoOutput.setMetadataObjectsDelegate(self, queue: queue)
        if session.canAddInput(videoInput!) {
            session.addInput(videoInput!)
        }
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        ///扫描类型
        videoOutput.metadataObjectTypes = [
            .qr,
            .code39,
            .code128,
            .code39Mod43,
            .ean13,
            .ean8,
            .code93]
        
        ///可识别区域  注意看这个rectOfInterest  不是一左上角为原点，以右上角为原点 并且rect的值是个比例在【0，1】之间
        videoOutput.rectOfInterest = CGRect(x: (scanZoneViewCenterY - (scanZoneViewWidth/2) + GPConstant.kNavigationBarHeight/2)/GPConstant.height, y: 1 - (GPConstant.width + scanZoneViewWidth)/2/GPConstant.width, width: scanZoneViewWidth/GPConstant.height, height: scanZoneViewWidth/GPConstant.width)
        
        view.layer.addSublayer(previewLayer)
        view.bringSubviewToFront(scanZoneView)
        view.bringSubviewToFront(backBtn)
        view.bringSubviewToFront(lampBtn)
    }
    
    
    private func createBezierPath( points : [CGPoint]) -> UIBezierPath {
        var points = points
        let path = UIBezierPath()
        path.move(to: points.first!)
        points.remove(at: 0)
        for point in points {
            path.addLine(to: point)
        }
        path.close()
        return path
    }
    
    private func scanLineImagViewAnmination() {
        UIView.animate(withDuration: 3) {
            let frame = self.scanLineView.frame
            var newY : CGFloat = self.leftTopPoint.y  + self.scanZoneViewWidth - frame.size.height
            if frame.origin.y > self.leftTopPoint.y {
                newY = self.leftTopPoint.y
            }
            
            let newFrame = CGRect(x: frame.origin.x, y: newY, width: frame.size.width, height: frame.size.height)
            self.scanLineView.frame = newFrame
        }
    }
    
    /// 开始扫描
    private func startRunning() {
        session.startRunning()
        setupTimer()
    }
    
    /// 结束扫描
    private func stopRunning()  {
        session.stopRunning()
        guard let time = timer else { return }
        time.invalidate()
        timer = nil
    }
    
    private func setupTimer()  {
        view.bringSubviewToFront(scanLineView)
        scanLineView.frame = CGRect(x: leftTopPoint.x, y: leftTopPoint.y , width: scanZoneViewWidth, height: 1)
        scanLineImagViewAnmination()
        timer = Timer(timeInterval: 3, repeats: true, block: { [weak self] (_) in
            self?.scanLineImagViewAnmination()
        })
        RunLoop.main.add(timer!, forMode: .common)
        timer?.fire()
    }
    
    private  func flashClick() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        let device = deviceDiscoverySession.devices.filter({ $0.position == .back }).first
        guard let dev = device else { return }
        
        if dev.torchMode == AVCaptureDevice.TorchMode.off {
            do {
                try dev.lockForConfiguration()
            } catch {
                return
            }
            dev.torchMode = .on
            dev.unlockForConfiguration()
        } else {
            do {
                try dev.lockForConfiguration()
            } catch {
                return
            }
            dev.torchMode = .off
            dev.unlockForConfiguration()
        }
    }
    
    private func recogniateQrcodeImage(_ image : UIImage) -> String {
        let ciImage:CIImage = CIImage(image: image)!
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context:nil,options:[CIDetectorAccuracy:CIDetectorAccuracyHigh])
        let feature = detector?.features(in: ciImage)
        let obj = feature?.first as? CIQRCodeFeature
        let str = obj?.messageString ?? ""
        print("scan result = " + str)
        return str
    }
}

extension ScanPageViewController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //扫描结果
        if metadataObjects.isEmpty {
           return
        }
        
        let obj: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        let result : String = obj.stringValue!
        print("扫描结果:",result)
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.scanResultLabel)
            self.scanResultLabel.text = result
        }
        stopRunning()
    }
}


// MARK: - ScanPageViewInput 

extension ScanPageViewController: ScanPageViewInput {}

// MARK: - ScanPageModuleBuilder

class ScanPageModuleBuilder {

    class func setupModule(handler: ScanPageModuleOutput? = nil) -> (UIViewController, ScanPageModuleInput) {
        let viewController = ScanPageViewController()
        
        let presenter = ScanPagePresenter()
        presenter.view = viewController
        presenter.transitionHandler = viewController
        presenter.outer = handler
        viewController.output = presenter
       
        let interactor = ScanPageInteractor()
        interactor.output = presenter
        presenter.interactor = interactor
        
        let input = presenter
        
        return (viewController, input)
    }
}
