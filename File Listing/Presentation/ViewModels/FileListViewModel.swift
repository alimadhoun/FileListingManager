//
//  FileListViewModel.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

protocol FileListViewModelDelegate: AnyObject {
    func didUpdateFiles()
    func didFailWithError(_ error: Error)
}

class FileListViewModel {
   
    private let getFilesUseCase: GetFilesUseCase
    private(set) var files: [FileItem] = []
    weak var delegate: FileListViewModelDelegate?
    
    init(getFilesUseCase: GetFilesUseCase) {
        self.getFilesUseCase = getFilesUseCase
    }
    
    func loadFiles() {
        do {
            files = try getFilesUseCase.execute()
            delegate?.didUpdateFiles()
        } catch {
            delegate?.didFailWithError(error)
        }
    }
    
    func numberOfFiles() -> Int {
        return files.count
    }
    
    func fileItem(at index: Int) -> FileItem? {
        guard index >= 0 && index < files.count else { return nil }
        return files[index]
    }
    
    func refreshFiles() {
        loadFiles()
    }
} 
