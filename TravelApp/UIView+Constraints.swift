//
//  UIView+Constraints.swift
//  TravelApp
//
//  Created by Anderson Oliveira on 01/04/23.
//

import UIKit

extension UIView {
    // MARK: Main functions
    func setAnchorsEqual(to reference: UIView, isSafeArea: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        isSafeArea
        ? self.setSafeAreaAnchorsTo(base: self, reference: reference)
        : self.setAnchorsTo(base: self, reference: reference)
    }
    
    func anchors(topReference: NSLayoutYAxisAnchor? = nil,
                 leadingReference: NSLayoutXAxisAnchor? = nil,
                 trailingReference: NSLayoutXAxisAnchor? = nil,
                 bottomReference: NSLayoutYAxisAnchor? = nil,
                 topPadding: CGFloat? = 0,
                 leadingPadding: CGFloat? = 0,
                 trailingPadding: CGFloat? = 0,
                 bottomPadding: CGFloat? = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topReference = topReference, let topPadding = topPadding { self.topAnchor.constraint(equalTo: topReference, constant: topPadding).isActive = true }
        if let leadingReference = leadingReference, let leadingPadding = leadingPadding { self.leadingAnchor.constraint(equalTo: leadingReference, constant: leadingPadding).isActive = true }
        if let trailingReference = trailingReference, let trailingPadding = trailingPadding { self.trailingAnchor.constraint(equalTo: trailingReference, constant: -trailingPadding).isActive = true }
        if let bottomReference = bottomReference, let bottomPadding = bottomPadding { self.bottomAnchor.constraint(equalTo: bottomReference, constant: -bottomPadding).isActive = true }
    }
    
    // MARK: Height and Width functions
    func equalWidth(to reference: UIView) {
        self.widthAnchor.constraint(equalTo: reference.widthAnchor).isActive = true
    }
    
    func equalHeight(to reference: UIView) {
        self.heightAnchor.constraint(equalTo: reference.heightAnchor).isActive = true
    }
    
    func setHeightGreaterThan(to reference: UIView) {
        self.heightAnchor.constraint(greaterThanOrEqualTo: reference.heightAnchor).isActive = true
    }
    
    func setHeightToScreenSize() {
        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
    }
    
    func setWidthToScreenSize() {
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    // MARK: Center X and Y functions
    func centerXEqualTo(_ reference: UIView) {
        self.centerXAnchor.constraint(equalTo: reference.centerXAnchor).isActive = true
    }
    
    func centerYEqualTo(_ reference: UIView) {
        self.centerYAnchor.constraint(equalTo: reference.centerYAnchor).isActive = true
    }
    
    func centerXYEqualTo(_ reference: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: reference.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: reference.centerYAnchor).isActive = true
    }
    
    func size(height: CGFloat? = 0, width: CGFloat? = 0) {
        if let height = height { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
        if let width = width { self.heightAnchor.constraint(equalToConstant: width).isActive = true }
    }
    
    
    // MARK: Private helper functions
    private func setAnchorsTo(base: UIView, reference: UIView) {
        NSLayoutConstraint.activate([
            base.topAnchor.constraint(equalTo: reference.topAnchor),
            base.leadingAnchor.constraint(equalTo: reference.leadingAnchor),
            base.trailingAnchor.constraint(equalTo: reference.trailingAnchor),
            base.bottomAnchor.constraint(equalTo: reference.bottomAnchor)
        ])
    }
    
    private func setSafeAreaAnchorsTo(base: UIView, reference: UIView) {
        NSLayoutConstraint.activate([
            base.topAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.topAnchor),
            base.leadingAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.leadingAnchor),
            base.trailingAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.trailingAnchor),
            base.bottomAnchor.constraint(equalTo: reference.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
