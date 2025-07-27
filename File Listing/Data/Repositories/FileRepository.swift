//
//  FileRepository.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

class FileRepository: FileRepositoryProtocol {
    
    private let fileManager = FileManager.default
    
    func getDocumentDirectoryFiles() throws -> [FileItem] {
        let documentsURL = try getDocumentsDirectory()
        let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [
            .fileSizeKey,
            .creationDateKey,
        ])
        
        var fileItems: [FileItem] = []
        
        for fileURL in fileURLs {
            let fileItem = try createFileItem(from: fileURL)
            fileItems.append(fileItem)
        }
        
        // Sort files in Alphabeticla order
        return fileItems.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
    
    func getFileDetails(filePath: String) throws -> FileItem {
        let fileURL = URL(fileURLWithPath: filePath)
        return try createFileItem(from: fileURL)
    }
    
    private func getDocumentsDirectory() throws -> URL {
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileRepositoryError.documentsDirectoryNotFound
        }
        return documentsURL
    }
    
    private func createFileItem(from fileURL: URL) throws -> FileItem {
        let resourceValues = try fileURL.resourceValues(forKeys: [
            .fileSizeKey,
            .creationDateKey
        ])
        
        guard let fileSize = resourceValues.fileSize,
              let creationDate = resourceValues.creationDate else {
            throw FileRepositoryError.failedToReadFileAttributes
        }
        
        let fileName = fileURL.lastPathComponent
        let fileExtension = fileURL.pathExtension
        
        return FileItem(
            name: fileName,
            path: fileURL.path,
            size: Int64(fileSize),
            creationDate: creationDate,
            fileExtension: fileExtension
        )
    }
}

enum FileRepositoryError: Error, LocalizedError {
    
    case documentsDirectoryNotFound
    case failedToReadFileAttributes
    case fileNotFound
    
    var errorDescription: String? {
        switch self {
        case .documentsDirectoryNotFound:
            return "Documents directory not found"
        case .failedToReadFileAttributes:
            return "Failed to read file attributes"
        case .fileNotFound:
            return "File not found"
        }
    }
}
