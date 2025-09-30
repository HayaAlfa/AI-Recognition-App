//
//  DetectionModel.swift
//  AI-Recognition
//
//  Created by Haya Alfakieh on 9/29/25.
//

import Foundation
import CoreGraphics // we import this to use CGRect


struct DetectionModel: Identifiable {
    let id: UUID = UUID()
    let label: String
    let score: Double
    let normalizedBounds: CGRect // CoreGraphics library, its a data type its a ractangle 
    
}

