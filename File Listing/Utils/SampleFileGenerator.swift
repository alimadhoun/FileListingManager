//
//  SampleFileGenerator.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

class SampleFileGenerator {
    
    // Create sample files of different types
    static private let sampleFiles = [
        ("README.txt", "This is a sample text file. It contains some basic information about the File Listing app."),
        ("Document.pdf", "PDF content would go here"),
        ("Image.jpg", "JPEG image data would go here"),
        ("Video.mp4", "MP4 video data would go here"),
        ("Audio.mp3", "MP3 audio data would go here"),
        ("Presentation.pptx", "PowerPoint presentation data would go here"),
        ("Spreadsheet.xlsx", "Excel spreadsheet data would go here"),
        ("Archive.zip", "ZIP archive data would go here")
    ]
    
    // Helper Function to simulate storing Data in Documents Folder
    static func createSampleFiles() {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find documents directory")
            return
        }
        
        for (fileName, content) in sampleFiles {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            debugPrint("File Path: \(fileURL.absoluteString)")
            
            // Only create file if it doesn't already exist
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try content.write(to: fileURL, atomically: true, encoding: .utf8)
                    print("Created sample file: \(fileName)")
                } catch {
                    print("Failed to create sample file \(fileName): \(error)")
                }
            }
        }
    }
    
    static func deletSamples() {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Could not find documents directory")
            return
        }
        
        for (fileName, _) in sampleFiles {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            do {
                if FileManager.default.fileExists(atPath: fileURL.path()) {
                    try FileManager.default.removeItem(atPath: fileURL.path())
                }
            } catch {
                print("Failed to delete sample file \(fileName): \(error)")
            }
        }
    }
}
