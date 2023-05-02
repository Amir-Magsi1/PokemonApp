//
//  FileManagerHelper.swift
//  Pokedex
//
//  Created by Amir Hussain on 08/02/2023.
//

import Foundation
import UIKit

/// Helper method to get image from local directory like documents.
class FileManagerHelper: NSObject {
    static func loadImageFromDocuments(name: String) -> UIImage? {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageURL = documentDirectory.appendingPathComponent(name)
        return UIImage(contentsOfFile: imageURL.path)
    }
}
