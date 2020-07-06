//
//  ScanPageViewController.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 01/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

import UIKit
import AVFoundation


class ScanPageViewController: UIViewController {

    var output: ScanPageViewOutput!
    private let bag = DisposeBag()
    private var timer: Timer!
    private var session: AVCaptureSession!
    
    lazy var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_main_back(), for: .normal)
        button.rx.tap.subscribe { (_) in
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: bag)
        return button
    }()
    
    lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        return view
    }()
    
    lazy var lampBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("打开", for: .normal)
        button.setImage(R.image.mine_scan_lamp(), for: .normal)
        button.rx.tap.subscribe { (_) in
            self.onClickLampBtn()
        }.disposed(by: bag)
        return button
    }()
    
    lazy var leftTopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_leftTop()
        return imageView
    }()
    
    lazy var leftBottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_leftBottom()
        return imageView
    }()
    
    lazy var rightTopImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_rightTop()
        return imageView
    }()
    
    lazy var rightBottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_rightBottom()
        return imageView
    }()
    
    lazy var scanLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_scan_line()
        return imageView
    }()
    
    var scanBoxWidth: CGFloat {
        GPConstant.width - 120
    }
    
    var scanBoxCenterY: CGFloat {
        GPConstant.height * 0.5
    }
    
    var leftTopPoint: CGPoint {
        CGPoint(x: 120 / 2, y: scanBoxCenterY - scanBoxWidth / 2)
    }
    
    var leftBottomPoint: CGPoint {
        CGPoint(x: 120 / 2, y: scanBoxCenterY + scanBoxWidth / 2)
    }
    
    var rightTopPoint: CGPoint {
        CGPoint(x: (scanBoxCenterY + scanBoxWidth) / 2, y: scanBoxCenterY - scanBoxWidth / 2)
    }
    
    var rightBottomPoint: CGPoint {
        CGPoint(x: (scanBoxCenterY + scanBoxWidth) / 2, y: scanBoxCenterY + scanBoxWidth / 2)
    }
    
    // 扫描区域
    lazy var scanPreViewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.frame = view.layer.bounds
        layer.backgroundColor = UIColor.black.cgColor
        
        return layer
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationHidden(for: true)
        checkAVCaptureDeviceStatus()
        scanLineImageViewAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationHidden(for: false)
    }

    // MARK: override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavItems()
        setupSubViews()
        addObserverForNoti()
        startScan()
    }
}

// MARK: - Assistant

extension ScanPageViewController {

    func setupNavItems() {}
    
    func setupSubViews() {
        view.backgroundColor = .gray51
        view.addSubview(backBtn)
        view.addSubview(centerView)
        view.addSubview(lampBtn)
        view.addSubview(leftTopImageView)
        view.addSubview(leftBottomImageView)
        view.addSubview(rightTopImageView)
        view.addSubview(rightBottomImageView)
        view.addSubview(scanLineImageView)
        setupSubviewsContraints()
    }
    
    func setupSubviewsContraints() {
        backBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(GPConstant.kToolBarHeight + GPConstant.kSafeAreaTopInset)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        
        centerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: scanBoxWidth, height: scanBoxWidth))
        }
        
        lampBtn.snp.makeConstraints { (make) in
            make.top.equalTo(centerView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        lampBtn.setupButtomImage_LabelStyle(style: .imageUpLabelDown, imageTitleSpace: 5)
        lampBtn.layoutIfNeeded()
        
        leftTopImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(centerView).offset(-1)
        }
        
        leftBottomImageView.snp.makeConstraints { (make) in
            make.left.equalTo(centerView).offset(-1)
            make.bottom.equalTo(centerView).offset(1)
        }
        
        rightTopImageView.snp.makeConstraints { (make) in
            make.right.equalTo(centerView).offset(1)
            make.top.equalTo(centerView).offset(-1)
        }
        
        rightBottomImageView.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(centerView).offset(1)
        }
    }
    
    private func checkAVCaptureDeviceStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .denied:
            KRProgressHUD.showWarning(withMessage: "已拒绝开启权限")
            self.alertPromptToAllowCameraAccessViaSetting()
        case .restricted:
            KRProgressHUD.showInfo(withMessage: "权限未开启")
            self.alertPromptToAllowCameraAccessViaSetting()
        case .notDetermined:
            KRProgressHUD.showWarning(withMessage: "需要用户开启权限，但是用户未授予或者已经拒绝")
            self.alertPromptToAllowCameraAccessViaSetting()
        case .authorized:
            setupAVSession()
        @unknown default:
            fatalError()
        }
    }
    
    private func setupAVSession() {
        let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: .video, position: .back)
        let device = deviceSession.devices.filter({ $0.position == .back}).first
        guard let dev = device else { return }
        let videoInput = try? AVCaptureDeviceInput(device: dev)
        let gloabalQueue = DispatchQueue.global()
        let videoOutput = AVCaptureMetadataOutput()
        videoOutput.setMetadataObjectsDelegate(self, queue: gloabalQueue)
        
        guard let input = videoInput else { return }
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        // type说明：
        /**
         qr：从QR代码生成的实例将返回此标识符作为type
         code39：从Code 39代码生成的实例返回此标识符作为type
         code128：从代码128代码生成的实例返回此标识符作为type
         code39Mo43：从代码39 mod 43代码生成的实例返回此标识符作为type
         code93：从代码93代码生成的实例返回此标识符作为type
         ean13：由EAN-13（包括UPC-A）代码生成的实例返回此标识符作为type
         ean8：从EAN-8代码生成的实例将此标识符返回为type
         */
        videoOutput.metadataObjectTypes = [.qr, .code39, .code128, .code39Mod43, .ean13, .ean8, .code93]
        let rect = CGRect(x: leftBottomPoint.x, y: scanBoxCenterY, width: scanBoxWidth, height: scanBoxWidth)
        videoOutput.rectOfInterest = convertRectOfInterest(rect: rect)
        view.layer.addSublayer(scanPreViewLayer)
    }
    
    // CGRect转换成百分比
    private func convertRectOfInterest(rect: CGRect) -> CGRect {
        let screenRect = view.frame
        let width = screenRect.width
        let height = screenRect.height
        let newX = 1 / (width / rect.minX)
        let newY = 1 / (height / rect.minY)
        let newWidth = 1 / (width / rect.width)
        let newHeight = 1 / (height / rect.height)
        
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
    
    private func onClickLampBtn() {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        let devices = session.devices.filter({ $0.position == .back}).first
        guard let device = devices else { return }
        if device.torchMode == AVCaptureDevice.TorchMode.off {
            do {
                try device.lockForConfiguration()
            } catch {
                return
            }
            device.torchMode = .on
            device.unlockForConfiguration()
            lampBtn.setTitle("关闭", for: .normal)
        } else {
            do {
                try device.lockForConfiguration()
            } catch {
                return
            }
            device.torchMode = .off
            device.unlockForConfiguration()
            lampBtn.setTitle("打开", for: .normal)
        }
    }
    
    private func createBezierPath(for points: [CGPoint]) -> UIBezierPath {
        var points = points
        let path = UIBezierPath()
        path.move(to: points.first!)
        points.remove(at: 0)
        
        _ = points.map({path.addLine(to: $0)})
        path.close()
        return path
    }
    
    private func startScan() {
        scanLineImageView.frame = CGRect(x: leftTopPoint.x, y: leftTopPoint.y, width: scanBoxWidth, height: 1)
        timer = Timer(timeInterval: 3, repeats: true, block: { (time) in
            self.scanLineImageViewAnimation()
        })
        RunLoop.main.add(timer, forMode: .common)
    }
    
    private func scanLineImageViewAnimation() {
        UIView.animate(withDuration: 3) {
            let frame = self.scanLineImageView.frame
            var newFrameY: CGFloat = self.leftTopPoint.y + self.scanBoxWidth - frame.size.height
            if frame.origin.y > self.leftTopPoint.y {
                newFrameY = self.leftTopPoint.y
            }
            
            let newFrame = CGRect(x: frame.origin.x, y: newFrameY, width: frame.size.width, height: frame.size.height)
            self.scanLineImageView.frame = newFrame
        }
    }
    
    
    func addObserverForNoti() {}
}

// MARK: - Network

extension ScanPageViewController {}

// MARK: - Delegate

extension ScanPageViewController {}

extension ScanPageViewController: AVCaptureMetadataOutputObjectsDelegate {
    
}

// MARK: - Selector

@objc extension ScanPageViewController {

    func onClickScanPageBtn(_ sender: UIButton) {}
    
    func onRecvScanPageNoti(_ noti: Notification) {}
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
