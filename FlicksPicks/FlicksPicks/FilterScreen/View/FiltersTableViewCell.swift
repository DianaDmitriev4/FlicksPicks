//
//  FiltersTableViewCell.swift
//  FlicksPicks
//
//  Created by User on 15.01.2024.
//

import SnapKit
import UIKit

final class FiltersTableViewCell: UITableViewCell {
    enum State {
        case select, unselect
        
        var image: UIImage {
            switch self {
            case .select:
                return UIImage.checkmark
            case .unselect:
                return UIImage(systemName: "circlebadge") ?? UIImage()
            }
        }
    }
    
    // MARK: - GUI Variables
    private lazy var checkboxImageView: UIImageView = {
        let view = UIImageView()
        
        view.image = State.unselect.image
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var genreNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubviews(views: [checkboxImageView, genreNameLabel])
        setupConstraint()
    }
    
    private func setupConstraint() {
        checkboxImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.height.width.equalTo(20)
            make.bottom.equalToSuperview()
        }
        
        genreNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkboxImageView.snp.trailing).offset(10)
            make.centerY.equalTo(checkboxImageView.snp.centerY)
        }
    }
    
    // MARK: - Methods
    func configureCell(genre: String, isSelected: Bool) {
        genreNameLabel.text = genre
        checkboxImageView.image = isSelected ? State.select.image : State.unselect.image
    }
}
