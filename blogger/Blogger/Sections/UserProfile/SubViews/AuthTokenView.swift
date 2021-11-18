//
//  AuthTokenView.swift
//  Blogger
//
//  Created by Connor Black on 07/11/2021.
//

import SwiftUI
#warning("TODO Copy to clip board")

struct AuthTokenView: View {
    
    let token: String
    
    var body: some View {
        VStack(spacing: 0) {
            
            CBText(text: "API Key", textType: .subHeading)
                .padding(.horizontal)
                .padding(.top)
            
            Button {
                print("Copy the key to clipboard")
            } label: {
                ZStack {
                    Capsule()
                        .fill(Colors.background)
                        .frame(height: 60)
                    
                    HStack {
                        
                        CBText(text: concealedToken, textType: .paragraph)
                            .lineLimit(1)
                        
                        Image(systemName: "doc.on.doc")
                            .renderingMode(.none)
                            .foregroundColor(Colors.textSecondary)
                            .frame(width: 45, height: 45)
                    }
                    .padding()
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Colors.backgroundOffset)
        )
    }
    
    var concealedToken: String {
        get {
            let prefix = token.prefix(5)
            let suffix = token.suffix(token.count - 5)
            let concealedArray = suffix.map { _ in
                "•"
            }
            let concealed = concealedArray.joined(separator: "")
            
            return prefix + concealed
        }
    }
}

struct AuthTokenView_Previews: PreviewProvider {
    static var previews: some View {
        AuthTokenView(token: "iuhrfiuhf98h3ii3uiur")
    }
}
