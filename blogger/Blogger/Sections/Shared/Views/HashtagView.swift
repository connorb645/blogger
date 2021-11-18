//
//  HashtagView.swift
//  Blogger
//
//  Created by Connor Black on 07/11/2021.
//

import SwiftUI

struct HashtagView: View {
    
    let text: String
    
    var body: some View {
        
        ZStack {
            Capsule()
                .fill(Colors.backgroundOffset)
            
            Text(text)
        }
        .frame(height: 35)
        
        
    }
}

struct HashtagView_Previews: PreviewProvider {
    static var previews: some View {
        HashtagView(text: "SomeText")
    }
}
