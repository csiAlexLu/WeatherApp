//
//  UIView+Extensions.swift
//  WeatherApp
//
//  Created by Alexander Luchenok on 4/5/23.
//

import UIKit

extension UIView {
    @discardableResult
    func add(to view: UIView) -> Self {
        view.addSubview(self)
        return self
    }

    @discardableResult
    func addSubviews(_ views: [UIView]) -> Self {
        views.forEach { self.addSubview($0) }
        return self
    }
}

extension UIView: AnchorableObject {
}

extension UILayoutGuide: AnchorableObject {
}

protocol AnchorableObject {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView {

    @discardableResult
    func pin(edges: UIRectEdge = .all, to view: AnchorableObject? = nil, with insets: UIEdgeInsets = .zero) -> Self {
        guard let pinToView = view ?? superview else {
            return self
        }

        if edges.contains(.top) {
            pinToView.topAnchor.constraint(equalTo: topAnchor, constant: -insets.top).isActive = true
        }
        if edges.contains(.left) {
            pinToView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -insets.left).isActive = true

        }
        if edges.contains(.right) {
            pinToView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right).isActive = true
        }

        if edges.contains(.bottom) {
            pinToView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).isActive = true
        }

        return self
    }

    @discardableResult
    func height(_ height: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
        return self
    }

    @discardableResult
    func width(_ width: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
        return self
    }

    @discardableResult
    func toBottom(of view: AnchorableObject? = nil, with inset: CGFloat = 0) -> Self {
        toBottomConstraints(of: view, with: inset)
        return self
    }

    @discardableResult
    private func toBottomConstraints(of view: AnchorableObject? = nil, with inset: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false

        guard let view = view ?? superview else {
            assertionFailure("Your view doesn't have a superview or view to pin.")
            return nil
        }

        let constraint = topAnchor.constraint(equalTo: view.bottomAnchor, constant: inset)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    func toRight(of view: AnchorableObject? = nil, with inset: CGFloat = 0) -> Self {
        toRightConstraints(of: view, with: inset)
        return self
    }

    @discardableResult
    func toRightConstraints(of view: AnchorableObject? = nil, with inset: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false

        guard let view = view ?? superview else {
            assertionFailure("Your view doesn't have a superview or view to pin.")
            return nil
        }

        let constraint = leftAnchor.constraint(equalTo: view.rightAnchor, constant: inset)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    func center(to view: UIView? = nil, offset: CGPoint = .zero) -> Self {
        centerConstraints(to: view, offset: offset)
        return self
    }

    @discardableResult
    func centerConstraints(to view: UIView? = nil, offset: CGPoint = .zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        guard let centerToView = view ?? superview else {
            return []
        }
        var constraints = [NSLayoutConstraint]()
        constraints.append(centerToView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offset.x))
        constraints.append(centerToView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offset.y))
        constraints.forEach { $0.priority = .required}

        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}

public extension UIEdgeInsets {
    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.init(top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0)
    }
}


