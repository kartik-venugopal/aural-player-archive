//
//  Supernova.swift
//  Aural
//
//  Copyright © 2023 Kartik Venugopal. All rights reserved.
//
//  This software is licensed under the MIT software license.
//  See the file "LICENSE" in the project root directory for license terms.
//
import SpriteKit

class Supernova: SKView, VisualizerViewProtocol {
    
    let type: VisualizationType = .supernova
    override var mouseDownCanMoveWindow: Bool {true}
    
    var data: BassFFTData = BassFFTData()
    
    var star: SKShapeNode!
    private lazy var gradientImage: NSImage = NSImage(named: "Supernova")!
    private lazy var gradientTexture = SKTexture(image: gradientImage)
    
    private var glowWidth: CGFloat = 50
    
    private static let minScale: CGFloat = 0.1
    
    func setUp(with fft: FFT) {
        data.setUp(for: fft)
    }
    
    func presentView(with fft: FFT) {
        
        data.setUp(for: fft)
        
        if self.scene == nil {
            
            let frame = self.frame
            
            let scene = SKScene(size: self.bounds.size)
            scene.backgroundColor = NSColor.black
            scene.anchorPoint = CGPoint.zero
            
            let radius: CGFloat = 4 * frame.height / 13
            
            self.star = SKShapeNode(circleOfRadius: radius)
            star.position = NSPoint(x: frame.width / 2, y: frame.height / 2)
            star.fillColor = NSColor.black
            
            star.strokeTexture = gradientTexture
            star.strokeColor = startColor
            star.lineWidth = 0.75 * radius
            star.glowWidth = radius / 2
            
            star.yScale = 1
            star.blendMode = .replace
            star.isAntialiased = true
            
            scene.addChild(star)
            presentScene(scene)
        }
        
        isPaused = false
    }
    
    func dismissView() {

        scene?.removeAllActions()
        star?.removeAllActions()
        
        isPaused = true
    }
    
    var startColor: NSColor = .blue
    var endColor: NSColor = .red
    
    func setColors(startColor: NSColor, endColor: NSColor) {
        
        self.startColor = startColor
        self.endColor = endColor
    }
    
    let updateActionDuration: TimeInterval = 0.05
    
    // 1 degree clockwise
    let rotationAngle: CGFloat = -.piOver180
    
    func update(with fft: FFT) {
        
        data.update(with: fft)
        updateForMagnitude(CGFloat(data.peakBassMagnitude))
    }
    
    func reset() {
        updateForMagnitude(0)
    }
    
    private func updateForMagnitude(_ magnitude: CGFloat) {
        
        if self.scene == nil {return}
        
        star.strokeColor = startColor.interpolate(endColor, magnitude)
        
        let scaleAction = SKAction.scale(to: max(Self.minScale, magnitude), duration: updateActionDuration)
        let rotateAction = SKAction.rotate(byAngle: rotationAngle, duration: updateActionDuration)
        
        star.run(SKAction.sequence([scaleAction, rotateAction]))
    }
}
