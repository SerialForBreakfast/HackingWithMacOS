//
//  DetailViewController.swift
//  Project1
//
//  Created by Joseph McCraw on 5/18/17.
//  Copyright © 2017 Joseph McCraw. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {

    @IBOutlet var imageView: NSImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func imageSelected(name: String) {
        imageView.image = NSImage(named: name)
    }
    
}
