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
    
    private var viewModel: GeneralViewModelProtocol
    private let square = 80
    
    var genresInUrl: [GenreTypes]? = nil {
        didSet {
            print("Genres was passed")
            viewModel.movies = []
            viewModel.loadData(genre: genresInUrl)
        }
    }
    
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
        
        setupUI()
        viewModel.loadData(genre: genresInUrl)
    }
    
    // MARK: - Private func
    @objc private func selectFilters() {
        let viewModel = FiltersViewModel()
        let navController = UINavigationController(rootViewController: FiltersTableViewController(viewModel: viewModel))
        navigationController?.present(navController, animated: true)
    }
    
    @objc private func showMovie() {
        let movies = viewModel.movies[viewModel.currentIndex]
        navigationController?.pushViewController(Movie(viewModel: movies), animated: true)
    }
    
    @objc private func declineMovie() {
        
    }
    
    @objc private func addMovieToFavorite() {
        
    }
    
    private func addGestureForImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showMovie))
        moviePosterView.addGestureRecognizer(gesture)
    }
    
    private func setupNavBar() {
        let filterButton = UIBarButtonItem(barButtonSystemItem: .action,
                                           target: self,
                                           action: #selector(selectFilters))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubviews(views: [declineButton, likeButton])
        declineButton.addSubview(declineImageView)
        likeButton.addSubview(likeImageView)
        
        makeConstraints()
        setupNavBar()
        addGestureForImage()
    }
    
    private func makeConstraints() {
        moviePosterView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(450)
            make.width.equalTo(300)
            make.top.equalToSuperview().inset(150)
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
