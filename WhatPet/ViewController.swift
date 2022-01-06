//
//  ViewController.swift
//  WhatPet
//
//  Created by Micaella Morales on 1/6/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var petImageView: UIImageView!
    @IBOutlet var labelView: UIView!
    @IBOutlet var petLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        print("camera tapped")
    }
    
}

