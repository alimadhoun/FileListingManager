//
//  FileItem.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import Foundation

struct FileItem {
    
    let name: String
    let path: String
    let size: Int64
    let creationDate: Date
    let fileExtension: String
    
    var formattedSize: String {
        return ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }
    
    var formattedCreationDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: creationDate)
    }
    
    var fileType: FileType {
        return FileType(rawValue: fileExtension.lowercased()) ?? .unknown
    }
}

enum FileType: String, CaseIterable {
    
    case pdf = "pdf"
    case jpg = "jpg"
    case jpeg = "jpeg"
    case png = "png"
    case txt = "txt"
    case doc = "doc"
    case docx = "docx"
    case mp4 = "mp4"
    case mov = "mov"
    case mp3 = "mp3"
    case unknown = ""
    
    var iconName: String {
        switch self {
        case .pdf:
            return "doc.richtext"
        case .jpg, .jpeg, .png:
            return "photo"
        case .txt:
            return "doc.text"
        case .doc, .docx:
            return "doc"
        case .mp4, .mov:
            return "video"
        case .mp3:
            return "music.note"
        case .unknown:
            return "doc"
        }
    }
} 
