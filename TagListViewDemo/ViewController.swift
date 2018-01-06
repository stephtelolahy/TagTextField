//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.emptyPlaceholder = "Start typing ..."
        tagListView.morePlaceholder = "Add another"
        tagListView.delegate = self
        tagListView.addTag("TagListView")
        tagListView.addTag("TEAChart")
        tagListView.addTag("Quark Shell")
        tagListView.insertTag("This should be the third tag", at: 2)
    }
}

extension ViewController: TagListViewDelegate {
    
    func tagListView(_ sender: TagListView, didAdd title: String) {
        print("Tag Added: \(title), \(sender)")
    }
    
    func tagListView(_ sender: TagListView, didRemove title: String) {
        print("Tag Removed: \(title), \(sender)")
    }
    
}

