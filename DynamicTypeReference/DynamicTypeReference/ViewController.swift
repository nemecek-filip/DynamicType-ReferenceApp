//
//  ViewController.swift
//  DynamicTypeReference
//
//  Created by Filip Němeček on 20/07/2019.
//  Copyright © 2019 Filip Němeček. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let allTextStyles: [UIFont.TextStyle] = [
        .largeTitle, .title1, .title2, .title3, .headline, .subheadline, .body,
        .callout, .footnote, .caption1, .caption2
    ]
    
    let allTextStyleNames = [
        "Large title", "Title 1", "Title 2", "Title 3", "Headline", "Subheadline", "Body",
        "Callout", "Footnote", "Caption 1", "Caption 2"
    ]
    
    private var customText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showInputForCustomText))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetToDefault))
    }
    
    @objc func resetToDefault() {
        customText = nil
        tableView.reloadData()
    }
    
    @objc func showInputForCustomText() {
        let ac = UIAlertController(title: "Try custom text", message: "Enter text to see how it will look like in different styles..", preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        
        ac.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self, weak ac] (_) in
            self?.customText = ac?.textFields![0].text
            self?.tableView.reloadData()
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTextStyles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let textStyle = allTextStyles[indexPath.row]
        
        if let customText = customText {
            cell.textLabel?.text = customText
            cell.detailTextLabel?.text = allTextStyleNames[indexPath.row]
        } else {
            cell.textLabel?.text = allTextStyleNames[indexPath.row]
            cell.detailTextLabel?.text = ""
        }
        
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
        cell.textLabel?.adjustsFontForContentSizeCategory = true
        return cell
    }
}



