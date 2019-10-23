//
//  UserCoaching.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//
//

import ARKit

protocol OnPlaneDetectedProtocol: class
{
    func onPlaneDetected()
}

class UserCoaching: ARSessionStateProtocot
{
    let coachingLabel: UILabel
    let arFacade: ARFacadeProtocol
    
    var delegate: OnPlaneDetectedProtocol!
    
    init(coachingLabel: UILabel, arFacade: ARFacadeProtocol)
    {
        self.coachingLabel = coachingLabel
        self.arFacade = arFacade
    }
    
    func onPlaneDetected() {
        DispatchQueue.main.async {
            self.coachingLabel.isHidden = false
            self.coachingLabel.text = "Плоскость найдена"
            self.delegate?.onPlaneDetected()
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5.0, execute: {
            self.coachingLabel.isHidden = true
        })
    }
    
    func onSessionInetarapted() {
        
        DispatchQueue.main.async {
            self.coachingLabel.isHidden = false
            self.coachingLabel.text = "Сессия прервана"
        }
    }
    
    func onSessionIneraptionEnded(_ session: ARSession) {
        
        DispatchQueue.main.async {
            self.coachingLabel.isHidden = false
            self.coachingLabel.text = "Сессия возобновлена"
        }
        
    }
    
    func onSessionDidFaledWith(error: Error) {
        DispatchQueue.main.async {
            self.coachingLabel.isHidden = false
            self.coachingLabel.text = "Ошибка:" + error.localizedDescription
        }
        
    }
    
    func onStateChangedToNormal() {
        DispatchQueue.main.async {
            self.coachingLabel.isHidden = false
            self.coachingLabel.text = "Трекается нормально"
        }
        
        if arFacade.isPlaneDetected()
        {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5) {
                {
                    self.coachingLabel.isHidden = true
                }()
            }
        }
        
    }
    
    func onStateChangedToNotAvalible() {
        DispatchQueue.main.async {
            self.coachingLabel.isHidden = false
            self.coachingLabel.text = "Недоступно"
        }
        
    }
    
    func onStateChangedToLimited(_ reason: ARCamera.TrackingState.Reason) {
        DispatchQueue.main.async {
            self.coachingLabel.isHidden = false
            switch reason {
            case .excessiveMotion:
                self.coachingLabel.text = "Двигайте телефон медленнее"
            case .initializing:
                self.coachingLabel.text = "Инициализация"
            case .insufficientFeatures:
                self.coachingLabel.text = "Недостаточно особенностей"
            case .relocalizing:
                self.coachingLabel.text = "Возобновление сессии"
                
            }
        }
        
    }
}
