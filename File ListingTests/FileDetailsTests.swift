//
//  FileDetailsTests.swift
//  File ListingTests
//
//  Created by Ali Madhoun on 26/07/2025.
//

import XCTest
@testable import File_Listing

final class FileDetailsTests: XCTestCase {
    
    var viewModel: FileDetailViewModel!
    let selectedFileName = "README.txt"

    override func setUp() {
        super.setUp()
        
        let repository = MockFileRepository()
        let fileDetailsUseCase = GetFileDetailsUseCase(repository: repository)
        let readmeFileItem = FileItem(
            name: selectedFileName,
            path: "\(selectedFileName)/path",
            size: Int64(5564),
            creationDate: Date(),
            fileExtension: "txt"
        )
        
        let vm = FileDetailViewModel(fileItem: readmeFileItem, getFileDetailsUseCase: fileDetailsUseCase)
        viewModel = vm
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
    }
    
    func test_fileDetails_returnsCorrectFileName() {
        
        XCTAssertTrue(viewModel.fileName == selectedFileName)
    }
    
    func test_fileDetails_returnsCorrectFileType() {
        XCTAssertTrue(viewModel.fileType == .txt)
    }

}
