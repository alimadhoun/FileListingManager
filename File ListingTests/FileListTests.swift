//
//  File_ListingTests.swift
//  File ListingTests
//
//  Created by Ali Madhoun on 26/07/2025.
//

import XCTest
@testable import File_Listing

final class FileListTests: XCTestCase {
    
    var viewModel: FileListViewModel!
    
    override func setUp() {
        super.setUp()
        
        let repository = MockFileRepository()
        let getFilesUseCase = GetFilesUseCase(repository: repository)
        let vm = FileListViewModel(getFilesUseCase: getFilesUseCase)
        self.viewModel = vm
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }

    func test_listFiles_returnsCorrectFileNames() {
        
        // 1- Load Files
        viewModel.loadFiles()
        
        // 2- Fetch File Names
        let fileNames = viewModel.files.map({ $0.name })
        
        // 3- Verify that View model returns correct file names
        let expectedStoredFileNames: [String] = [
            "Xcode.dmg",
            "final_exam.pdf",
            "movie.mp4"
        ]
        
        fileNames.forEach { fileName in
            XCTAssertTrue(expectedStoredFileNames.contains(fileName))
        }
    }
    
    func test_getFileMetadata_returnsCorrectSize1() {
        
        // 1- Load Files
        viewModel.loadFiles()
        
        // 2- Fetch File sizes
        let firstFile = viewModel.files.first
        let fileExamFileSize = firstFile?.size
        let expectedFileSize = Int64(123)
        
        // 3- Verify that view model returns correct file size
        XCTAssertTrue(fileExamFileSize == expectedFileSize)
    }
    
    func test_getFileMetadata_returnsCorrectCreationDate() {
        
        // 1- Load Files
        viewModel.loadFiles()
        
        // 2- Fetch File creation Dates
        let fileCreationDates = viewModel.files.map({ $0.creationDate })
        
        // 3- Verify that view model returns correct creation dates By Comparing File creation dates with expected Date.
        // The difference between expectedCreationDate and actual file creation dates shouldn't be more than 1 Sec.
        let expectedCreationDate = Date()
        fileCreationDates.forEach { creationDate in
            XCTAssertTrue((expectedCreationDate.timeIntervalSince(creationDate)) < 1)
        }
    }
}
