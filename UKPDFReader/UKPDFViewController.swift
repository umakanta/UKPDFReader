//
//  UKPDFViewController.swift
//  UKPDFReader
//
//  Created by Umakanta Sahoo on 16/09/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit
import PDFKit

let Device_Height = UIScreen.main.bounds.size.height
let Device_Width = UIScreen.main.bounds.size.width

public protocol PDFInfoDelegate: class {
    func pdfInfo(total:Int, now:Int)
}


public class UKPDFViewController: UIViewController {
    
    private let pdfUrl: URL
    private let document: PDFDocument!
    private let outline: PDFOutline?
    private var pdfView = PDFView()
    private var thumbnailView = PDFThumbnailView()
    
    private var contentsViewController: ContentsTableViewController!
    weak var delegate: PDFInfoDelegate?
    
    public var pdfDisplayDirection: PDFDisplayDirection = .horizontal {
        willSet {
            pdfView.displayDirection = newValue
        }
    }
    
    public var showContentsButton: Bool = true
    public var showThumbnailView: Bool = false
    public var pdfTitle: String = "" {
        willSet {
            self.title = newValue
        }
    }
    
    public init(pdfUrl: URL, delegate: PDFInfoDelegate) {
        self.pdfUrl = pdfUrl
        self.delegate = delegate
        
        self.document = PDFDocument(url: pdfUrl)
        self.outline = document.outlineRoot
        pdfView.document = document
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        if showContentsButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "三", style: .plain, target: self, action: #selector(toggleOutline))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(back))
        
        self.setupPDFView()
        
        if showThumbnailView {
            setupThumbnailView()
        }
        
        // Add page changed listener
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePageChange(notification:)),
            name: .PDFViewPageChanged,
            object: pdfView)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.removeObserver(self, name: .PDFViewPageChanged, object: nil)
    }
    
    @objc private func handlePageChange(notification: Notification) {
        // Do your stuff here like hiding PDFThumbnailView...
        let pdfVieww = notification.object as! PDFView
        delegate?.pdfInfo(total: document.pageCount, now: document.index(for: pdfVieww.currentPage!)+1)
        //print("Total: \(document.pageCount), Now: \(document.index(for: pdfVieww.currentPage!)+1)")
    }
    
    @objc private func handleAnnotationHit(notification: Notification) {

        print("handleAnnotationHit..")
        let pdfVieww = notification.object as! PDFView
        print("Total: \(document.pageCount), Now: \(document.index(for: pdfVieww.currentPage!)+1 )")
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.safeAreaLayoutGuide.layoutFrame
        
        if showThumbnailView {
            let thumbanilHeight: CGFloat = Device_Height * 0.15
            thumbnailView.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraintsWithFormat(format: "H:|[v0]|", views: thumbnailView)
            view.addConstraintsWithFormat(format: "V:[v0(\(thumbanilHeight))]|", views: thumbnailView)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK:- Helper Methods ------
    
    private func setupPDFView() {
        pdfView.displayDirection = pdfDisplayDirection
        pdfView.usePageViewController(true)
        pdfView.pageBreakMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        pdfView.autoScales = true

        view.addSubview(pdfView)
    }
    
    private func setupThumbnailView() {
        thumbnailView.pdfView = pdfView
        thumbnailView.backgroundColor = UIColor(displayP3Red: 179/255, green: 179/255, blue: 179/255, alpha: 0.5)
        thumbnailView.layoutMode = .horizontal
        thumbnailView.thumbnailSize = CGSize(width: Device_Width * 0.1, height: Device_Height * 0.1)
        thumbnailView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.addSubview(thumbnailView)
    }
    
    @objc private func toggleOutline(sender: UIBarButtonItem) {
        
        guard let outline = self.outline else {
            print("PDF has no outline")
            return
        }
        
        if contentsViewController == nil {
            contentsViewController = ContentsTableViewController(outline: outline, delegate: self)
            contentsViewController.preferredContentSize = CGSize(width: (Device_Width*0.7), height: (Device_Height*0.7))
            contentsViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        }
        
        //popover
        let popoverPresentationCon = contentsViewController.popoverPresentationController
        
        let targetView = sender.value(forKey: "view") as! UIView
        popoverPresentationCon?.sourceView = targetView
        popoverPresentationCon?.sourceRect = targetView.bounds
        popoverPresentationCon?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverPresentationCon?.delegate = self
        
        self.present(contentsViewController, animated: true, completion: nil)
    }
    
    @objc private func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func customizeNavBar(backgroundcolor: UIColor = .white, titleTextcolor: UIColor = .black, titleFont: UIFont = UIFont.boldSystemFont(ofSize: 18.0), buttonTextcolor: UIColor = .black, buttonFont: UIFont = UIFont.systemFont(ofSize: 16.0)) {
        UINavigationBar.appearance().barTintColor =  backgroundcolor
        
        UINavigationBar.appearance().tintColor = buttonTextcolor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleTextcolor, NSAttributedString.Key.font: titleFont]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: buttonTextcolor, NSAttributedString.Key.font: buttonFont], for: .normal)
    }
}

extension UKPDFViewController: ContentsDelegate {
    func goTo(page: PDFPage) {
        pdfView.go(to: page)
    }
}

extension UKPDFViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

