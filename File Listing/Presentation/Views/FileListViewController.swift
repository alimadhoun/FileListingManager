//
//  FileListViewController.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import UIKit

class FileListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: FileListViewModel
    weak var coordinator: FileListCoordinator?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // This handles Empty State.
        label.text = "No files found in Documents directory"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Lifecycle
    init(viewModel: FileListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        setupUI()
        setupTableView()
        loadFiles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshFiles()
    }
    
    // MARK: - Setup
    private func setupDependencies() {
        viewModel.delegate = self
    }
    
    private func setupUI() {
        title = "Files"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FileTableViewCell.self, forCellReuseIdentifier: FileTableViewCell.ID)
        
        refreshControl.addTarget(self, action: #selector(refreshFiles), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func loadFiles() {
        viewModel.loadFiles()
    }
    
    @objc private func refreshFiles() {
        viewModel.refreshFiles()
    }
    
    private func updateEmptyState() {
        let hasFiles = viewModel.numberOfFiles() > 0
        emptyStateLabel.isHidden = hasFiles
        tableView.isHidden = !hasFiles
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - FileListViewModelDelegate
extension FileListViewController: FileListViewModelDelegate {
    func didUpdateFiles() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            self?.updateEmptyState()
        }
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.showError(error)
        }
    }
}

// MARK: - UITableViewDataSource
extension FileListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFiles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FileTableViewCell.ID, for: indexPath) as? FileTableViewCell,
              let fileItem = viewModel.fileItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configure(fileItem: fileItem)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FileListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let fileItem = viewModel.fileItem(at: indexPath.row) else { return }
        coordinator?.showFileDetail(for: fileItem)
    }
} 
