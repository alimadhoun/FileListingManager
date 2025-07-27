//
//  FileRepositoryProtocol.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

protocol FileRepositoryProtocol {
    
    func getDocumentDirectoryFiles() throws -> [FileItem]
    func getFileDetails(filePath: String) throws -> FileItem
}
