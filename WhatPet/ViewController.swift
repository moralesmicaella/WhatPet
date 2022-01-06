//
//  ViewController.swift
//  WhatPet
//
//  Created by Micaella Morales on 1/6/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet var petImageView: UIImageView!
    @IBOutlet var labelView: UIView!
    @IBOutlet var petLabel: UILabel!
    
    let animationView = AnimationView(name: "loading")
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnimation()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        petImageView.layer.cornerRadius = petImageView.frame.width / 2
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let libraryAction = UIAlertAction(title: "Choose from Library", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(libraryAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - Animation  methods
    
    func setAnimation() {
        animationView.frame = labelView.frame
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.isHidden = true
        
        view.addSubview(animationView)
    }
    
    func startAnimation() {
        animationView.play()
        animationView.isHidden = false
        labelView.isHidden = true
    }
    
    func stopAnimation() {
        animationView.stop()
        animationView.isHidden = true
        labelView.isHidden = false
    }

    
}

//MARK: - Image picker delegate methods

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        startAnimation()
        
        if let userPickedImage = info[.editedImage] as? UIImage {
            petImageView.image =  userPickedImage
        }
        
    }
}
