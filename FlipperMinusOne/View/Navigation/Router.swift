//
//  Router.swift
//  FlipperMinusOne
//
//  Created by Joao Roberto Fernandes Magalhaes on 21/07/25.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    static var shared: Router = Router()
    
    @Published var path = NavigationPath()
    
    func goToJammerRadar() {
        path.append(Views.PulseDetectorView.self)
    }
    
}
