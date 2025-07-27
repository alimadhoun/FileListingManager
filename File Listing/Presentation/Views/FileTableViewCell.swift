//
//  FileTableViewCell.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import UIKit

class FileTableViewCell: UITableViewCell {
    
    static let ID = "FileTableViewCell"
    
    private let fileIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private let fileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let fileSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // This makes sure we setupUI only once.
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        
        contentView.addSubview(fileIconImageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(fileNameLabel)
        stackView.addArrangedSubview(fileSizeLabel)
        stackView.addArrangedSubview(creationDateLabel)
        
        NSLayoutConstraint.activate([
            fileIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fileIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            fileIconImageView.widthAnchor.constraint(equalToConstant: 40),
            fileIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: fileIconImageView.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70)
        ])
    }
    
    // MARK: - configure cell
    func configure(fileItem: FileItem) {
        fileNameLabel.text = fileItem.name
        fileSizeLabel.text = fileItem.formattedSize
        creationDateLabel.text = fileItem.formattedCreationDate
        
        let iconImage = UIImage(systemName: fileItem.fileType.iconName)
        fileIconImageView.image = iconImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fileNameLabel.text = nil
        fileSizeLabel.text = nil
        creationDateLabel.text = nil
        fileIconImageView.image = nil
    }
} 
