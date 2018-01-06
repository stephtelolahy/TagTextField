//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        
        tagListView.emptyPlaceholder = "Start typing ..."
        tagListView.morePlaceholder = "Add another"
        tagListView.delegate = self
        
//        tagListView.addTag("TagListView")
//        tagListView.addTag("TEAChart")
//        tagListView.addTag("Quark Shell")
//        tagListView.insertTag("This should be the third tag", at: 2)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ViewController: TagListViewDelegate {
    
    func tagListView(_ sender: TagListView, didAdd title: String) {
        print("Tag Added: \(title), \(sender)")
        self.tableView.reloadData()
    }
    
    func tagListView(_ sender: TagListView, didRemove title: String) {
        print("Tag Removed: \(title), \(sender)")
        self.tableView.reloadData()
    }
    
}

