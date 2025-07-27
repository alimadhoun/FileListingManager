//
//  GetFilesUseCase.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

class GetFilesUseCase {
    
    private let repository: FileRepositoryProtocol
    
    init(repository: FileRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> [FileItem] {
        return try repository.getDocumentDirectoryFiles()
    }
} 
