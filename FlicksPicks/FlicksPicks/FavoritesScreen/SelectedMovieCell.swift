//
//  SelectedMovieCell.swift.swift
//  FlicksPicks
//
//  Created by User on 14.01.2024.
//

import UIKit

final class SelectedMovieCell: UITableViewCell {
    // MARK: - GUI variables
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var dataView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 19)
        
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    private lazy var ratingLabelView: UIView = {
        let view = UIView()
        
        view.layer.borderWidth = 1
        
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
        dataView.addSubviews(views: [titleLabel, yearLabel])
        ratingLabelView.addSubview(ratingLabel)
        containerView.addSubviews(views: [posterImageView, dataView, ratingLabelView])
        addSubview(containerView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        posterImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalTo(60)
            make.leading.equalToSuperview().inset(30)
        }
        
        dataView.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(30)
            make.trailing.equalTo(ratingLabelView.snp.leading).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.top.equalTo(ratingLabelView.snp.centerY)
        }
        
        ratingLabelView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(posterImageView.snp.centerY)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}
