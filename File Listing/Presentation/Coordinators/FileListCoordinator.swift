//
//  FileListCoordinator.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import UIKit

protocol FileListCoordinatorDelegate: AnyObject {
    func fileListCoordinatorDidFinish(_ coordinator: FileListCoordinator)
}

class FileListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var delegate: FileListCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showFileList()
    }
    
    private func showFileList() {
        let repository = FileRepository()
        let getFilesUseCase = GetFilesUseCase(repository: repository)
        let viewModel = FileListViewModel(getFilesUseCase: getFilesUseCase)
        let fileListViewController = FileListViewController(viewModel: viewModel)
        
        fileListViewController.coordinator = self
        navigationController.pushViewController(fileListViewController, animated: false)
    }
    
    func showFileDetail(for fileItem: FileItem) {
        
        // Inject dependancies
        let repository = FileRepository()
        let getFileDetailsUseCase = GetFileDetailsUseCase(repository: repository)
        let viewModel = FileDetailViewModel(fileItem: fileItem, getFileDetailsUseCase: getFileDetailsUseCase)
        let detailViewController = FileDetailViewController(viewModel: viewModel)
        
        detailViewController.coordinator = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func dismissFileDetail() {
        navigationController.popViewController(animated: true)
    }
}
