//
//  ViewController.swift
//  IOS_marathon_8
//
//  Created by Наталья Коновалова on 22.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    private enum Constants {
        static let navigationBarLargeTitleViewName = "_UINavigationBarLargeTitleView"
        static let personImageName = "person.crop.circle.fill"
        static let avatarName = "Avatar"
        static let personImageViewSize: CGFloat = 36
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = .init(width: view.bounds.width, height: view.bounds.height * 1.5)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.personImageName)
        imageView.tintColor = .systemGray4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }
    
    private func setupInitialState() {
        addSubviews()
        setupNavigationBarSettings()
        setupPersonImageView()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
    }
    
    private func setupNavigationBarSettings() {
        title = Constants.avatarName
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupPersonImageView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let navController = self.navigationController else { return }
            if let navBarLargeTitleViewType = NSClassFromString(Constants.navigationBarLargeTitleViewName) as? UIView.Type,
               // navBarLargeTitleView - view на котором расположен LargeTitle
               let navBarLargeTitleView = self.findSubview(parentView: navController.view, type: navBarLargeTitleViewType),
               // largeTitleLabel - LargeTitle
               let largeTitleLabel = self.findSubview(parentView: navController.view, type: UILabel.self) as? UILabel
            {
                navBarLargeTitleView.addSubview(self.personImageView)
                self.setupNavigationBarConstraints(mainView: navBarLargeTitleView, subview: largeTitleLabel)
            }
        }
    }
    
    func findSubview(parentView: UIView, type: UIView.Type) -> UIView? {
        for subview in parentView.subviews {
            if subview.isKind(of: type) {
                return subview
            } else if let foundSubview = findSubview(parentView: subview, type: type) {
                return foundSubview
            }
        }
        return nil
    }
}

extension ViewController {
    
    func setupConstraints () {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func setupNavigationBarConstraints(mainView: UIView, subview: UIView) {
        NSLayoutConstraint.activate([
            personImageView.trailingAnchor.constraint(equalTo: mainView.layoutMarginsGuide.trailingAnchor),
            personImageView.centerYAnchor.constraint(equalTo: subview.centerYAnchor),
            personImageView.heightAnchor.constraint(equalToConstant: Constants.personImageViewSize),
            personImageView.widthAnchor.constraint(equalToConstant: Constants.personImageViewSize)
        ])
    }
}
