//
//  Movie.swift
//  FlicksPicks
//
//  Created by User on 04.01.2024.
//

import UIKit

final class Movie: UIViewController {
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = 0.8
        
        return view
    }()
    
    private lazy var titleLabel = makeLabel(size: 40, textColor: .white, numberOfLines: 1)
    private lazy var yearLabel = makeLabel(size: 13, textColor: .black, numberOfLines: 1)
    private lazy var ratingLabel = makeLabel(size: 13, textColor: .black, numberOfLines: 1)
    //    private lazy var countriesLabel = makeLabel(size: 19)
    //    private lazy var genresLabel = makeLabel(size: 19)
    private lazy var descriptionLabel = makeLabel(size: 23, textColor: .black, numberOfLines: 0)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    // MARK: - Properties
    private let viewModel: MovieResponseViewModelProtocol
    
    // MARK: - Initialization
    init(viewModel: MovieResponseViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private methods
    private func makeLabel(size: CGFloat, textColor: UIColor, numberOfLines: Int) -> UILabel {
        let label: UILabel = {
            
            let label = UILabel()
            
            label.font = .systemFont(ofSize: size)
            label.textAlignment = .left
            label.numberOfLines = numberOfLines
            label.lineBreakMode = .byWordWrapping
            label.textColor = textColor
            
            return label
        }()
        return label
    }
    
    private func setupUI() {
        title = viewModel.name
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        titleView.addSubview(titleLabel)
        contentView.addSubviews(views: [
            imageView,
            titleView,
            descriptionLabel,
            yearLabel,
            ratingLabel
        ])
        setData()
        setupConstraints()
    }
    
    private func setData() {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        yearLabel.text = "Year: " + String(viewModel.year)
        ratingLabel.text = "Rating: " + String(viewModel.rating)
        
        if let data = viewModel.imageData {
            imageView.image = UIImage(data: data)
        }
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
        }
        
        titleView.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.bottom)
            make.height.equalTo(titleLabel.snp.height)
            make.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}
