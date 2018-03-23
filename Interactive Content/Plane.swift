//
//  Plane.swift
//  eBibelot-iOS
//
//  Created by Yauheni Rahouski on 3/23/18.
//  Copyright © 2018 LeverX. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

@available(iOS 11.0, *)
class Plane: SCNNode {

    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        self.anchor = anchor
        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        let material = SCNMaterial()
        let img = UIImage(named: "tron_grid")
        material.diffuse.contents = img
        planeGeometry.materials = [material]
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        
        planeNode.transform = SCNMatrix4MakeRotation(-.pi / 2.0, 1.0, 0.0, 0.0)
        setTextureScale()
        addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(anchor: ARPlaneAnchor) {

        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)
        
        position = SCNVector3Make(anchor.center.x , 0, anchor.center.z )
        setTextureScale()
    }

    
    func setTextureScale() {
        let width: CGFloat = planeGeometry.width
        let height: CGFloat = planeGeometry.height

        let material = planeGeometry.materials.first
        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(height), 1)
        material?.diffuse.wrapS = .repeat
        material?.diffuse.wrapT = .repeat
    }
}
