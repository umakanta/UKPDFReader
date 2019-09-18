//
//  ContentsTableViewController.swift
//  UKPDFReader
//
//  Created by Umakanta Sahoo on 17/09/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit
import PDFKit

protocol ContentsDelegate: class {
    func goTo(page: PDFPage)
}

class ContentsTableViewController: UITableViewController {

    let outline: PDFOutline
    weak var delegate: ContentsDelegate?
    
    init(outline: PDFOutline, delegate: ContentsDelegate?) {
        self.outline = outline
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outline.numberOfChildren
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        // Configure the cell...
        if let label = cell.textLabel, let title = outline.child(at: indexPath.row)?.label {
            label.text = String(title)
        }
        
        if indexPath.row == 0 { cell.textLabel?.font = UIFont.boldSystemFont(ofSize: (cell.textLabel?.font.pointSize)!+2) }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let page = outline.child(at: indexPath.row)?.destination?.page {
            delegate?.goTo(page: page)
        }
        
        dismiss(animated: true, completion: nil)
    }

}
