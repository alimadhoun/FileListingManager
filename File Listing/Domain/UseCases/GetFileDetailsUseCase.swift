//
//  GetFileDetailsUseCase.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

class GetFileDetailsUseCase {
    
    private let repository: FileRepositoryProtocol
    
    init(repository: FileRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(filePath: String) throws -> FileItem {
        return try repository.getFileDetails(filePath: filePath)
    }
} 
