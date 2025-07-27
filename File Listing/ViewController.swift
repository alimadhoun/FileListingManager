//
//  ViewController.swift
//  File Listing
//
//  Created by Ali Madhoun on 26/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    var rootCoordinator: RootCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFileListingApp()
    }
    
    private func setupFileListingApp() {
        // Create sample files for demonstration
        SampleFileGenerator.createSampleFiles()
        
        let navigationController = UINavigationController()
        let appCoordinator = RootCoordinator(navigationController: navigationController)
        
        self.rootCoordinator = appCoordinator
        
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.view.frame = view.bounds
        navigationController.didMove(toParent: self)
        
        appCoordinator.start()
    }
}

