//
//  LoginView.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import SwiftUI

struct LoginView<R: LoginViewRouterProtocol>: View {
    
    @ObservedObject var viewModel: LoginViewModel
    @StateObject var router: R
    
    init(router: R, viewModel: LoginViewModel) {
        self._router = StateObject(wrappedValue: router)
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Email Address", text: $viewModel.emailAddressText)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Password", text: $viewModel.passwordText)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    
                
                Button("Let's Go") {
                    Task {
                        let successfulLogin = await viewModel.login()
                        
                        if successfulLogin {
                            router.dismiss()
                        }
                    }
                }
            }
            
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(router: LoginViewRouter(isPresented: .constant(false)),
                      viewModel: .init())
        }
    }
}
