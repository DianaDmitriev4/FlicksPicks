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
    lazy private var cardContainer: СardСontainer = {
        let view = СardСontainer(viewModel: self.viewModel)
        
        return view
    }()
    
    lazy private var declineButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(declineMovie), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var declineImageView: UIImageView = {
        let view = UIImageView()
        
        let image = UIImage(named: "decline")
        view.image = image
        
        return view
    }()
    
    lazy private var likeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addMovieToFavorite), for: .touchUpInside)
        
        return button
    }()
    
    lazy private var likeImageView: UIImageView = {
        let view = UIImageView()
        
        let image = UIImage(named: "like")
        view.image = image
        
        return view
    }()
    
    lazy private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        
        return indicator
    }()
    
    private var viewModel: GeneralViewModelProtocol
    private var selectedGenres: [GenreTypes] = []
    private let square = 80 //For buttons
    
    // MARK: - Initialization
    init(viewModel: GeneralViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData(genre: nil)
        setupUI()
    }
    
    // MARK: - Private func
    @objc private func selectFilters() {
        let filtersViewModel = FiltersViewModel()
        filtersViewModel.disappearClosure = { [weak self] selectedTypes in
            self?.viewModel.movies = []
            self?.viewModel.currentIndex = 0
            self?.viewModel.page = 0
            self?.cardContainer.reloadData()
            self?.selectedGenres = selectedTypes
            self?.viewModel.loadData(genre: selectedTypes)
        }
        let navController = UINavigationController(rootViewController: FiltersTableViewController(viewModel: filtersViewModel))
        navigationController?.present(navController, animated: true)
    }
    
    @objc private func showMovie() {
        let movies = viewModel.movies[viewModel.currentIndex]
        navigationController?.pushViewController(Movie(viewModel: movies), animated: true)
    }
    
    @objc private func declineMovie() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            if let self {
                cardContainer.swipeDidEnd(on: cardContainer.cardViews[viewModel.currentIndex], needSave: false)
                declineButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }) { [weak self] _ in
            UIView.animate(withDuration: 0.1, animations: {
                self?.declineButton.transform = .identity
            })
        }
    }
    
    @objc private func addMovieToFavorite() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            if let self {
                cardContainer.swipeDidEnd(on: cardContainer.cardViews[viewModel.currentIndex], needSave: true)
                likeButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }) { [weak self] _ in
            UIView.animate(withDuration: 0.1, animations: {
                self?.likeButton.transform = .identity
            })
        }
    }
    
    private func addGestureForImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showMovie))
        cardContainer.addGestureRecognizer(gesture)
    }
    
    private func setupNavBar() {
        let filterButton = UIBarButtonItem(barButtonSystemItem: .search,
                                           target: self,
                                           action: #selector(selectFilters))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(cardContainer)
        view.addSubviews(views: [declineButton, likeButton, activityIndicator])
        declineButton.addSubview(declineImageView)
        likeButton.addSubview(likeImageView)
        
        makeConstraints()
        setupNavBar()
        addGestureForImage()
        setupViewModel()
    }
    
    private func makeAlert() {
        viewModel.showError = { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(action)
            self?.navigationController?.present(alert, animated: true)
        }
    }
    
    private func setupViewModel() {
        viewModel.startLoading = { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.endLoading = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
        
        viewModel.getMoreMovies = { [weak self] in
            self?.viewModel.loadData(genre: self?.selectedGenres)
        }
        
        makeAlert()
    }
    
    private func makeConstraints() {
        cardContainer.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(450)
            make.width.equalTo(300)
            make.top.equalToSuperview().inset(150)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        declineButton.snp.makeConstraints { make in
            make.height.width.equalTo(square)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(35)
            make.leading.equalToSuperview().inset(50)
        }
        
        declineImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.height.width.equalTo(square)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(35)
            make.trailing.equalToSuperview().inset(50)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
