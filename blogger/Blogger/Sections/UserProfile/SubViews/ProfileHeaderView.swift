//
//  ProfileHeaderView.swift
//  Blogger
//
//  Created by Connor Black on 05/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeaderView: View {
    
    let profileImageUrl: String?
    let title: String
    let subTitle: String
    let editable: Bool
    
    var body: some View {
        // Profile Header
        HStack {
            // Profile Picture
            
            if let profileImageUrl = profileImageUrl, let url = URL(string: profileImageUrl) {
                WebImage(url: url)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } else {
                Circle()
                    .fill(Colors.backgroundOffset)
                    .frame(width: 100, height: 100)
            }
            
            // Name and blurb
            VStack() {
                CBText(text: title, textType: .heading)
                    
                CBText(text: subTitle, textType: .subHeading)
            }
            .frame(maxWidth: .infinity)
            
            // Edit Button
            if editable {
                Button {
                    print("Edit Details")
                } label: {
                    Image(systemName: "highlighter")
                        .renderingMode(.none)
                        .foregroundColor(Colors.textSecondary)
                        .frame(width: 45, height: 45)
                }
            }
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(profileImageUrl: "",
                          title: "Connor Black",
                          subTitle: "iOS Developer",
                          editable: true)
    }
}
