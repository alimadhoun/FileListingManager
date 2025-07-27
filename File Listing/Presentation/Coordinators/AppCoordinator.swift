//
//  AppCoordinator.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import UIKit

class RootCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showFileListFlow()
    }
    
    private func showFileListFlow() {
        let fileListCoordinator = FileListCoordinator(navigationController: navigationController)
        fileListCoordinator.delegate = self
        childCoordinators.append(fileListCoordinator)
        fileListCoordinator.start()
    }
}

extension RootCoordinator: FileListCoordinatorDelegate {
    func fileListCoordinatorDidFinish(_ coordinator: FileListCoordinator) {
        childDidFinish(coordinator)
    }
} 
