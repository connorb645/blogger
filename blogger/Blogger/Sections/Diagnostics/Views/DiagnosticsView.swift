//
//  DiagnosticsView.swift
//  Blogger
//
//  Created by Connor Black on 13/11/2021.
//

import SwiftUI

struct DiagnosticsView<R: Router>: View {
    
    @ObservedObject var viewModel: DiagnosticsViewModel
    @StateObject var router: R
    
    init(router: R,
         viewModel: DiagnosticsViewModel) {
        self._router = StateObject(wrappedValue: router)
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Button {
                    viewModel.removeAuthDetails()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 2.5)
                            .fill(Color.red)
                        CBText(text: "Clear Auth Details", textType: .paragraph, alignment: .center, colorInverted: true)
                    }
                    .frame(height: 45)
                }
            }
            .padding()
        }
    }
}

struct DiagnosticsView_Previews: PreviewProvider {
    static var previews: some View {
        let router = Router(isPresented: .constant(false))
        let viewModel = DiagnosticsViewModel()
        DiagnosticsView(router: router, viewModel: viewModel)
    }
}
