//
//  ListItem.swift
//  Blogger
//
//  Created by Connor Black on 27/10/2021.
//

import SwiftUI

struct ListItemView: View {
    
    let heading: String
    let subHeading: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(heading)
                .fontWeight(.semibold)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(subHeading)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(heading: "Fake Heading", subHeading: "Connor Black")
    }
}
