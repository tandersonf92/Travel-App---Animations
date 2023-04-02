//
//  OnboardingViewController.swift
//  TravelApp
//
//  Created by Anderson Oliveira on 01/04/23.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private var items: [OnboardingItem] = []
    
    private var currentPage: Int = 0
    
    // MARK: Properties
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var blurView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
        return view
    }()
    
    private lazy var pageControl: UIPageControl = UIPageControl()
    
    private lazy var viewMaisProTopo: UIView = UIView()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Futura", size: 20)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupOnboardingItems()
        setupPageControl()
        setupScreen(index: currentPage)
        setupGestures()
    }
    
    private func setupOnboardingItems() {
        items = OnboardingItem.getOnboardingItems()
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func setupScreen(index: Int) {
        titleLabel.text = items[index].title
        descriptionLabel.text = items[index].detail
        pageControl.currentPage = index
        updateBackgroundImage(index: index)
        
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func isOverLastItem() -> Bool {
        currentPage == self.items.count
    }
    
    private func updateBackgroundImage(index: Int) {
        let image = items[index].bgImage
        UIView.transition(with: backgroundImageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            guard let self = self else { return }
            self.backgroundImageView.image = image
        }, completion: nil)
        
    }
    
    @objc private func handleTapAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.view.isUserInteractionEnabled = false
            self.firstAnimatePart(animateElement: self.titleLabel)
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.secondAnimatePart(animateElement: self.titleLabel)
            } completion: { _ in
                self.animateDescription()
            }
        }
    }
    
    private func animateDescription() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.firstAnimatePart(animateElement: self.descriptionLabel)
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.secondAnimatePart(animateElement: self.descriptionLabel)
            } completion: { _ in
                self.currentPage += 1
                self.resetLabelsToMainState()
                self.view.isUserInteractionEnabled = true
                if self.isOverLastItem() {
                    self.currentPage = 0
                    self.showMainApp()
                } else {
                    self.setupScreen(index: self.currentPage)
                }
            }
        }
    }
    
    private func firstAnimatePart(animateElement: UIView) {
        animateElement.alpha = 0.8
        animateElement.transform = CGAffineTransform(translationX: -30, y: 0)
    }
    
    private func secondAnimatePart(animateElement: UIView) {
        animateElement.alpha = 0
        animateElement.transform = CGAffineTransform(translationX: 0, y: -550)
    }
    
    private func showMainApp() -> Void {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = HomeScreenViewController()
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    private func resetLabelsToMainState() {
        titleLabel.alpha = 1
        descriptionLabel.alpha = 1.0
        titleLabel.transform = .identity
        descriptionLabel.transform = .identity
    }
}

extension OnboardingViewController: ViewConfiguration {
    func configViews() {}
    
    func buildViews() {
        [backgroundImageView, blurView].forEach(view.addSubview)
        [viewMaisProTopo, pageControl].forEach(blurView.addSubview)
        viewMaisProTopo.addSubview(labelsStackView)
        [titleLabel, descriptionLabel].forEach(labelsStackView.addArrangedSubview)
    }
    
    func setupConstraints() {
        backgroundImageView.setAnchorsEqual(to: view)
        blurView.setAnchorsEqual(to: view)
        
        pageControl.anchors(bottomReference: blurView.safeAreaLayoutGuide.bottomAnchor, bottomPadding: 24)
        pageControl.centerXEqualTo(blurView)
        
        viewMaisProTopo.anchors(topReference: blurView.topAnchor,
                                leadingReference: blurView.leadingAnchor,
                                trailingReference: blurView.trailingAnchor,
                                bottomReference: pageControl.topAnchor)
        
        labelsStackView.centerXYEqualTo(viewMaisProTopo)
        labelsStackView.anchors(leadingReference: viewMaisProTopo.leadingAnchor,
                                trailingReference: viewMaisProTopo.trailingAnchor,
                                leadingPadding: 24,
                                trailingPadding: 24)
    }
}
