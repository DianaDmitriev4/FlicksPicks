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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(moviePosterView)
        makeConstraints()
    }
    
    // MARK: - Private func
    private func makeConstraints() {
        moviePosterView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).inset(-60)
            make.height.equalTo(400)
            make.width.equalTo(300)
        }
    }
    
    private func setupUI() {
        
    }
}

