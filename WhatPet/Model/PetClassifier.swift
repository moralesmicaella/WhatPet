//
//  PetImageClassifierModel.swift
//  WhatPet
//
//  Created by Micaella Morales on 1/6/22.
//

import UIKit
import CoreML
import Vision

protocol PetClassifierDelegate {
    func didFinishClassification(_ petImageClassifierModel: PetClassifier, petClassification: String)
}

struct PetClassifier {
    
    var delegate: PetClassifierDelegate?
    
    private func createModel() -> VNCoreMLModel {
        let config = MLModelConfiguration()
        guard let petImageClassifier = try? PetImageClassifier(configuration: config) else {
            fatalError("App failed to create a pet image classifier model instance.")
        }
        guard let model = try? VNCoreMLModel(for: petImageClassifier.model) else {
            fatalError("App failed to create a VNCoreModel.")
        }
        
        return model
    }
    
    func getPetClassification(petImage: CIImage) {
        let model = createModel()
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let result = request.results?.first as? VNClassificationObservation else {
                fatalError("App failed to complete classification")
            }
            self.delegate?.didFinishClassification(self, petClassification: result.identifier)
        }
        
        let handler = VNImageRequestHandler(ciImage: petImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
