//
//  SelectedMovieCell.swift.swift
//  FlicksPicks
//
//  Created by User on 14.01.2024.
//

import UIKit

final class SelectedMovieCell: UITableViewCell {
    // MARK: - GUI variables
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 5
        
        return view
    }()
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 19)
        
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var ratingLabelView: UIView = {
        let view = UIView()
        
        view.layer.borderWidth = 2
        
        return view
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func set(_ source: MovieResponseViewModel) {
        guard let data = source.imageData else { return }
        posterImageView.image = UIImage(data: data)
        titleLabel.text = source.name
        ratingLabel.text = String(source.rating)
        yearLabel.text = String(source.year)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        ratingLabelView.addSubview(ratingLabel)
        addSubviews(views: [
            posterImageView,
            titleLabel,
            yearLabel,
            ratingLabelView
        ])
        
        setConstraint()
    }
    
    private func setConstraint() {
        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(50)
            make.leading.equalToSuperview().inset(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(ratingLabelView.snp.leading).offset(5)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(ratingLabelView.snp.leading).offset(5)
            make.top.equalTo(titleLabel).offset(5)
        }
        
        ratingLabelView.snp.makeConstraints { make in
            let square = frame.height / 2
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(square)
            make.width.equalTo(square)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

