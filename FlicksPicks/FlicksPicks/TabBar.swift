//
//  TabBar.swift
//  FlicksPicks
//
//  Created by User on 02.01.2024.
//

import UIKit

final class TabBar: UITabBarController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        
        view.tintColor = .black
    }
    // MARK: - Private methods
    private func setupVC() {
        viewControllers = [
            setupNavigationController(rootViewController: GeneralViewController(viewModel: GeneralViewModel()),
                                      image: UIImage(systemName: "house") ?? .cancel),
            setupNavigationController(rootViewController: SelectedMovies(),
                                      image: UIImage(systemName: "bookmark") ?? .cancel)
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController, 
                                           image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
