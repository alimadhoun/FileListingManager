//
//  FileDetailViewModel.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

class FileDetailViewModel {
    
    private let fileItem: FileItem
    private let getFileDetailsUseCase: GetFileDetailsUseCase
    
    init(fileItem: FileItem, getFileDetailsUseCase: GetFileDetailsUseCase) {
        self.fileItem = fileItem
        self.getFileDetailsUseCase = getFileDetailsUseCase
    }
    
    var fileName: String {
        return fileItem.name
    }
    
    var fileSize: String {
        return fileItem.formattedSize
    }
    
    var creationDate: String {
        return fileItem.formattedCreationDate
    }
    
    var fileType: FileType {
        return fileItem.fileType
    }
    
    var iconName: String {
        return fileType.iconName
    }
}
