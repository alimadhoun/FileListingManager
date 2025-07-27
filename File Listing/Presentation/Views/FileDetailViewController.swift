//
//  FileDetailViewController.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import UIKit

class FileDetailViewController: UIViewController {
    
    private let viewModel: FileDetailViewModel
    weak var coordinator: FileListCoordinator?
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        return stack
    }()
    
    // MARK: - Initialization
    init(viewModel: FileDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithViewModel()
    }
    
    // MARK: - Setup
    private func setupUI() {
        title = "File Details"
        view.backgroundColor = .systemBackground
        
        // Add back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        view.addSubview(contentView)
        
        contentView.addSubview(fileIconImageView)
        contentView.addSubview(fileNameLabel)
        contentView.addSubview(detailsStackView)
        
        setupConstraints()
        setupDetailsStack()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Content view
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 435),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // File icon
            fileIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            fileIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            fileIconImageView.widthAnchor.constraint(equalToConstant: 80),
            fileIconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // File name
            fileNameLabel.topAnchor.constraint(equalTo: fileIconImageView.bottomAnchor, constant: 20),
            fileNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fileNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Details stack
            detailsStackView.topAnchor.constraint(equalTo: fileNameLabel.bottomAnchor, constant: 40),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func setupDetailsStack() {
        let fileSizeRow = createDetailRow(title: "File Size", value: viewModel.fileSize)
        let creationDateRow = createDetailRow(title: "Creation Date", value: viewModel.creationDate)
        
        detailsStackView.addArrangedSubview(fileSizeRow)
        detailsStackView.addArrangedSubview(creationDateRow)
    }
    
    private func createDetailRow(title: String, value: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .label
        titleLabel.text = title
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        valueLabel.textColor = .secondaryLabel
        valueLabel.text = value
        valueLabel.numberOfLines = 0
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            valueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
        
        return containerView
    }
    
    private func configureWithViewModel() {
        fileNameLabel.text = viewModel.fileName
        let iconImage = UIImage(systemName: viewModel.iconName)
        fileIconImageView.image = iconImage
    }
    
    @objc private func backButtonTapped() {
        coordinator?.dismissFileDetail()
    }
} 
