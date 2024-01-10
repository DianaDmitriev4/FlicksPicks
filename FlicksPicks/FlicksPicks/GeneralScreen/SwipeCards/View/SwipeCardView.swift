//
//  SwipeCardView.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import SnapKit
import UIKit

final class SwipeCardView : UIView {
    
    //MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "mock1")
        return imageView
    }()
    var url = "" {
        didSet {
            print(url)
        }
    }
    
    var dataSource : MovieResponse?

var delegate: SwipeCardsDelegate?
    let viewModel = GeneralViewModel()
//MARK: - Initialization
override init(frame: CGRect) {
    super.init(frame: .zero)
    
    addSubview(imageView)
    setupConstraints()
    addPanGestureOnCards()
    
}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

// MARK: - Private methods
    func getImage() {
        if let url = dataSource?.poster?.url {
            ApiManager.getImage(url: url) { result in
                switch result {
                case .success(let data):
                    self.imageView.image = UIImage(data: data)
                case .failure(let failure):
                    print("lox")
                }
            }
        }
    }
    
//    func getImage() {
//        getURL()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//            self?.setImage()
//            print("ZAGRUZILOS")
//        }
//    }
//    
//    func setImage() {
//        ApiManager.getImage(url: url) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let dataPict):
//                    self?.imageView.image = UIImage(data: dataPict)
//                case .failure(_):
//                    print("lox")
//                }
//            }
//        }
//    }
//
//func getURL() {
//    ApiManager.getFilms { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let data):
//                            self.url = data.poster?.url ?? ""
//                case .failure(let failure):
//                    print("")
//                }
//            }
//        }
//    }
    
private func setupConstraints() {
    imageView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
    }
}

private func addPanGestureOnCards() {
    self.isUserInteractionEnabled = true
    addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
}

@objc private func handlePanGesture(sender: UIPanGestureRecognizer){
    let card = sender.view as! SwipeCardView
    let point = sender.translation(in: self)
    let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
    
    switch sender.state {
    case .ended:
        // Swipe right
        if (card.center.x) > 400 {
            delegate?.swipeDidEnd(on: card)
            UIView.animate(withDuration: 0.2) {
                card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                card.alpha = 0
                self.layoutIfNeeded()
            }
            return
            // Swipe left
        }else if card.center.x < -65 {
            delegate?.swipeDidEnd(on: card)
            UIView.animate(withDuration: 0.2) {
                card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                card.alpha = 0
                self.layoutIfNeeded()
            }
            return
        }
        UIView.animate(withDuration: 0.2) {
            card.transform = .identity
            card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            self.layoutIfNeeded()
        }
    case .changed:
        let rotation = tan(point.x / (self.frame.width * 2.0))
        card.transform = CGAffineTransform(rotationAngle: rotation)
    default:
        break
    }
}
}

