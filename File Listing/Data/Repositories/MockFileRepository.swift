//
//  MockFileRepository.swift
//  File Listing
//
//  Created by Ali Madhoun on 27/07/2025.
//

import Foundation

class MockFileRepository: FileRepositoryProtocol {
    
    private let mockFiles: [FileItem] = [
        .init(name: "Xcode.dmg", path: "/Xcode/path", size: Int64(123), creationDate: Date(), fileExtension: "dmg"),
        .init(name: "final_exam.pdf", path: "/final_exam.pdf/path", size: Int64(543), creationDate: Date(), fileExtension: "pdf"),
        .init(name: "movie.mp4", path: "/movie/path", size: Int64(111), creationDate: Date(), fileExtension: "mp4")
    ]
    
    func getDocumentDirectoryFiles() throws -> [FileItem] {
        return mockFiles
    }
    
    func getFileDetails(filePath: String) throws -> FileItem {
        
        guard let fileItem = mockFiles.first(where: { $0.path == filePath }) else {
            throw MockFileRepositoryError.fileNotFound
        }
        
        return fileItem
    }
}

enum MockFileRepositoryError: Error, LocalizedError {
    
    case fileNotFound
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            "File couldn't be found."
        }
    }
}
