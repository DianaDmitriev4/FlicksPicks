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
    lazy private var moviePosterView: СardСontainer = {
        let view = СardСontainer(viewModel: self.viewModel)
        view.dataSource = self
        
        return view
    }()
    
    private var viewModel: GeneralViewModelProtocol
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
        addGestureForImage()
        setupNavBar()
//        viewModel.loadData(count: 4, genre: )
        viewModel.loadData()
        setupViewModel()
    }
    
    // MARK: - Private func
    @objc private func selectFilters() {
//        let vc = Filters()
//        navigationController?.present(vc, animated: true)
    }
    
    @objc private func showMovie() {
        let movies = viewModel.movies[viewModel.currentIndex]
        navigationController?.pushViewController(Movie(viewModel: movies), animated: true)
    }
    
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.moviePosterView.dataSource = self
//            self?.navigationItem.title = self?.viewModel.movies[self?.moviePosterView.currentIndex ?? 0].name
            print("ЗАМЫКАНИЕ СРАБОТАЛО")
        }
    }
    
    private func addGestureForImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showMovie))
        moviePosterView.addGestureRecognizer(gesture)
    }
    
    private func makeConstraints() {
        moviePosterView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(450)
            make.width.equalTo(300)
            make.top.equalToSuperview().inset(150)
        }
    }
    
    private func setupNavBar() {
        let filterButton = UIBarButtonItem(barButtonSystemItem: .action,
                                           target: self,
                                           action: #selector(selectFilters))
        navigationItem.rightBarButtonItem = filterButton
    }
}

// MARK: - SwipeCardsDataProtocol
extension GeneralViewController : SwipeCardsDataSource {
    
    func numberOfCardsToShow() -> Int {
        return viewModel.movies.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView(viewModel: self.viewModel)
        card.dataSource = viewModel.movies[index]
        return card
    }
}
