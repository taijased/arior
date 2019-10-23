//
//  ARFaced.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 27/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
import GameplayKit
protocol ARSessionStateProtocot: class
{
    func onPlaneDetected()
    func onSessionInetarapted()
    func onSessionIneraptionEnded(_ session: ARSession)
    func onSessionDidFaledWith(error: Error)
    func onStateChangedToNormal()
    func onStateChangedToNotAvalible()
    func onStateChangedToLimited(_ reason: ARCamera.TrackingState.Reason)

}

class ARFacade: NSObject, ARFacadeProtocol
{

    
    let viewModel: ARViewModel
    
    let sceneView: ARSCNView
    
    let planeDetector: PlaneDetector
    
    let wallBuilder: WallBuilder
    
    let interactions: ARInteractions
    
    var delegate: ARSessionStateProtocot!
    
    init(viewModel: ARViewModel)
    {
        self.viewModel = viewModel
        self.sceneView = viewModel.sceneView
        self.planeDetector = PlaneDetector(sceneView: sceneView)
        self.wallBuilder = WallBuilder(sceneView: sceneView, planeDetector: planeDetector)
        self.interactions = ARInteractions(sceneView: sceneView, planeDetector: planeDetector)
        super.init()
        wallBuilder.delegate = viewModel
        sceneView.delegate = self
        sceneView.session.delegate = self   
    }
    
    func runARSession(planeDetection: ARWorldTrackingConfiguration.PlaneDetection = [.horizontal], autoenableDefaultLighting : Bool = true)
    {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = planeDetection
        sceneView.showsStatistics = true
        sceneView.session.run(configuration, options: .resetTracking)
        sceneView.autoenablesDefaultLighting = autoenableDefaultLighting

    }
    
    func resetTracking()
    {
        runARSession()
        wallBuilder.reset()
        wallBuilder.raycaster.planeDetector.updatePlaneAnchor()
    }
    
    func textureWalls()
    {
        let path = "ScnAssets.scnassets/beer.png"
        wallBuilder.testureSegments(textureLength: 0.4625, textureWidth: 1, textureImage: UIImage(named: path))
    }
    
    func hideAreaLabels()
    {
        
    }
    
    func isPlaneDetected() -> Bool {
        return planeDetector.isPlaneDetected
    }
    
}




