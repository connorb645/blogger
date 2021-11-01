//
//  LoginView.swift
//  Blogger
//
//  Created by Connor Black on 26/10/2021.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
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
                    viewModel.login()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(viewModel: .init())
        }
    }
}
