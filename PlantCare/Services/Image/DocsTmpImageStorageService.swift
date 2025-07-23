//
// Copyright © 2025 Sage.
// All Rights Reserved.

import UIKit

struct DocsImagesStorageService {
    var fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    var rootURL: URL? {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}


extension DocsImagesStorageService: ImagesStorageWritterService {}
extension DocsImagesStorageService: ImagesStorageReaderService {}
