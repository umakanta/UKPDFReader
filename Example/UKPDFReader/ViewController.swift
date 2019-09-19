//
//  ViewController.swift
//  UKPDFReader
//
//  Created by umakanta1987@gmail.com on 09/18/2019.
//  Copyright (c) 2019 umakanta1987@gmail.com. All rights reserved.
//

import UIKit
import UKPDFReader

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openPDFAction(_ sender: UIButton) {
        
        guard let path = Bundle.main.url(forResource: "swift", withExtension: "pdf") else {
            print("failed to unwrap fileURL")
            return
        }
        
        let pdfViewController = UKPDFViewController(pdfUrl: path, delegate: self)
        //optional values
        pdfViewController.pdfDisplayDirection = .horizontal
        pdfViewController.showContentsButton = true
        pdfViewController.showThumbnailView = false
        pdfViewController.pdfTitle = "UKPdfReader"
        
        pdfViewController.customizeNavBar(titleTextcolor: .red, titleFont: UIFont.boldSystemFont(ofSize: 24.0), buttonTextcolor: .blue, buttonFont: UIFont.boldSystemFont(ofSize: 18.0))
        
        let navController = UINavigationController.init(rootViewController: pdfViewController)
        present(navController, animated: true, completion: nil)
    }
    
}

extension ViewController: PDFInfoDelegate {
    func pdfInfo(total: Int, now: Int) {
        print("Total page: \(total), Now page: \(now)")
    }
}

