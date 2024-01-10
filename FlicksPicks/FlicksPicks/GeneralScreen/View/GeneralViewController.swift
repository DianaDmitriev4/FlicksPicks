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
    private let viewModel: GeneralViewModelProtocol
    
    lazy private var moviePosterView: СardСontainer = {
        let view = СardСontainer()
        view.viewModel = self.viewModel
        
        return view
    }()
    
    lazy private var labelView: UILabel = {
        let view = UILabel()
        
        return view
    }()

    lazy private var imageView: UIImageView = {
        let view = UIImageView()
        
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
//        view.addSubview(labelView)
//        view.addSubview(imageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        makeConstraints()
//        moviePosterView.dataSource = self
        addGestureForImage()
        setupNavBar()
        viewModel.loadData()
    }
    
    // MARK: - Private func


    @objc private func selectFilters() {
        let vc = Filters()
        navigationController?.present(vc, animated: true)
    }
    @objc private func showMovie() {
//        guard let movies = viewModel.movies as? MovieResponseViewModel else { return }
        navigationController?.pushViewController(MovieDetails(), animated: true)
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
        
//        labelView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        imageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
    private func setupNavBar() {
        let filterButton = UIBarButtonItem(barButtonSystemItem: .action,
                                           target: self,
                                           action: #selector(selectFilters))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setupUI() {
        
    }
}

// MARK: - SwipeCardsDataProtocol
    
   
