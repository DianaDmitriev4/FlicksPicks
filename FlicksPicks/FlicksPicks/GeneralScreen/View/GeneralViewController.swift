//
//  GeneralViewController.swift
//  FlicksPicks
//
//  Created by User on 31.12.2023.
//

import SnapKit
import UIKit

final class GeneralViewController: UIViewController {
    // MARK: - Properties
    var viewModelData = [
        MovieResponse(image: UIImage(named: "mock1") ?? .add, title: "Avatar"),
        MovieResponse(image: UIImage(named: "mock2") ?? .add, title: "Телекинез"),
        MovieResponse(image: UIImage(named: "mock3") ?? .add, title: "Остров проклятых"),
        MovieResponse(image: UIImage(named: "mock4") ?? .add, title: "Время")
        ]
        
    private let viewModel: GeneralViewModelProtocol
    
    lazy private var moviePosterView: СardСontainer = {
        let view = СardСontainer()
        
        return view
    }()
    
    // MARK: - Initialization
    init(viewModel: GeneralViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func loadView() {
        view = UIView()
        view.addSubview(moviePosterView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        makeConstraints()
        moviePosterView.dataSource = self
    }
    
    // MARK: - Private func
    private func makeConstraints() {
        moviePosterView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(500)
            make.width.equalTo(350)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(50)
        }

    }
    
    private func setupUI() {
        
    }
}

extension GeneralViewController: SwipeCardsDataSource {
    
    func numberOfCardsToShow() -> Int {
        return viewModelData.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModelData[index]
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
}

