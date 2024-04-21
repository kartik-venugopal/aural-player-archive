//
//  NSViewExtensions.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import Cocoa

extension NSView {
    
    var width: CGFloat {frame.width}
    
    var height: CGFloat {frame.height}
    
    var size: NSSize {frame.size}
    
    func resize(_ width: CGFloat, _ height: CGFloat) {
        setFrameSize(NSMakeSize(width, height))
    }
    
    var isShown: Bool {!isHidden}
    
    func hide() {
        self.isHidden = true
    }
    
    func show() {
        self.isHidden = false
    }
    
    // NOTE - Should not simply set the flag here because show() and hide() may be overriden and need to be called somewhere in a subview.
    func hideIf(_ condition: Bool) {
        condition ? hide() : show()
    }
    
    // NOTE - Should not simply set the flag here because show() and hide() may be overriden and need to be called somewhere in a subview.
    func showIf(_ condition: Bool) {
        condition ? show() : hide()
    }
    
    var isVisible: Bool {
        
        var curView: NSView? = self
        while curView != nil {
            
            if curView!.isHidden {return false}
            curView = curView!.superview
        }
        
        return true
    }
    
    func redraw() {
        self.setNeedsDisplay(self.bounds)
    }
    
    func addSubviews(_ subViews: NSView...) {
        subViews.forEach {self.addSubview($0)}
    }
    
    func bringToFront() {
        
        let superView = self.superview
        self.removeFromSuperview()
        superView?.addSubview(self, positioned: .above, relativeTo: nil)
    }
    
    func removeAllTrackingAreas() {
        
        for area in self.trackingAreas {
            self.removeTrackingArea(area)
        }
    }
    
    func anchorToSuperview() {
        
        if let superView = self.superview {
            anchorToView(superView)
        }
    }
    
    func anchorToView(_ otherView: NSView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        self.leadingAnchor.constraint(equalTo: otherView.leadingAnchor),
        self.trailingAnchor.constraint(equalTo: otherView.trailingAnchor),
        self.topAnchor.constraint(equalTo: otherView.topAnchor),
        self.bottomAnchor.constraint(equalTo: otherView.bottomAnchor)])
    }
    
    func moveUp(distance: CGFloat) {
        frame.origin.y += distance
    }
    
    func moveLeft(distance: CGFloat) {
        frame.origin.x -= distance
    }
    
    func moveRight(distance: CGFloat) {
        self.frame.origin.x += distance
    }
    
    // MARK - Static functions
    
    static func showViews(_ views: NSView...) {
        views.forEach {$0.show()}
    }

    static func hideViews(_ views: NSView...) {
        views.forEach {$0.hide()}
    }
    
    func activateAndAddConstraint(_ constraint: NSLayoutConstraint) {
        
        constraint.isActive = true
        self.addConstraint(constraint)
    }
    
    func activateAndAddConstraints(_ constraints: NSLayoutConstraint...) {
        
        for constraint in constraints {
            constraint.isActive = true
            self.addConstraint(constraint)
        }
    }
    
    func deactivateAndRemoveConstraint(_ constraint: NSLayoutConstraint) {
        
        constraint.isActive = false
        self.removeConstraint(constraint)
    }
    
    func removeAllConstraintsFromSuperview(attributes: [NSLayoutConstraint.Attribute]? = nil) {
        
        guard let superview = self.superview else {return}
            
        superview.constraints.filter {$0.firstItem === self && attributes?.contains($0.firstAttribute) ?? true}.forEach {superview.deactivateAndRemoveConstraint($0)}
    }
}

extension NSViewController {
    
    func forceLoadingOfView() {
        
        if !self.isViewLoaded {
            _ = self.view
        }
    }
}
