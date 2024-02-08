//
//  TabBar.swift
//  FlicksPicks
//
//  Created by User on 02.01.2024.
//

import UIKit

final class TabBar: UITabBarController {
    // MARK: - Properties
    let viewModel = GeneralViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        
        view.tintColor = .black
    }
    
    // MARK: - Private methods
    private func setupVC() {
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(viewModel: viewModel), image: UIImage(systemName: "house") ?? .add),
            setupNavigationController(rootViewController: SelectedMovies(viewModel: viewModel), image: UIImage(systemName: "bookmark") ?? .add)
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController, image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
