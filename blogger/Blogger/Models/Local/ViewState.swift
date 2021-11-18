//
//  ViewState.swift
//  Blogger
//
//  Created by Connor Black on 07/11/2021.
//

import Foundation
import SwiftUI

enum ViewState<Content: View> {
    case loading
    case loaded(view: Content)
    case error(error: Error)
}
