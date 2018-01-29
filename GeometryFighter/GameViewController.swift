//
//  GameViewController.swift
//  GeometryFighter
//
//  Created by Ruben Albor on 23/01/18.
//  Copyright © 2018 Radish. All rights reserved.
//

import SceneKit

class GameViewController: UIViewController {
    
    var scnView : SCNView!
    var scnScene : SCNScene!
    var cameraNode : SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView()
    {
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
    }
    
    func setupScene()
    {
        scnScene = SCNScene()
        scnView.scene = scnScene
        scnScene.background.contents = "GeometryFighter.scnassets/Textures/Background_Diffuse.png"
    }
    
    func setupCamera ()
    {
        //1
        cameraNode = SCNNode()
        
        //2
        cameraNode.camera = SCNCamera()
        
        //3
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        
        //4
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape()
    {
        var geometry : SCNGeometry
        var shape : ShapeType
        
        shape = ShapeType.random()
        print(shape)
        
        switch shape
        {
        case ShapeType.box:
            geometry = SCNBox(width: 2.0, height: 2.0, length: 2.0, chamferRadius: 0.0)
        case ShapeType.capsule:
            geometry = SCNCapsule(capRadius: 2.5, height: 1.0)
        case ShapeType.cone:
            geometry = SCNCone(topRadius: 1.0, bottomRadius: 2.0, height: 2.5)
        case ShapeType.pyramid:
            geometry = SCNPyramid (width: 2.0, height: 3.5, length: 2.0)
        case ShapeType.sphere:
            geometry = SCNSphere(radius: 3.5)
        case ShapeType.torus:
            geometry = SCNTorus(ringRadius: 1.5, pipeRadius: 2.0)
        default:
            geometry = SCNTube(innerRadius: 1.0, outerRadius: 1.5, height: 3.0)
        }
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        geometry.materials.first?.diffuse.contents = UIColor.random()
        
        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        
        let force = SCNVector3(x: randomX , y: randomY , z: 0)
        
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        //To-Do
        scnScene.rootNode.addChildNode(geometryNode)
    }
}
