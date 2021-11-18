//
//  CBText.swift
//  Blogger
//
//  Created by Connor Black on 05/11/2021.
//

import SwiftUI

enum TextType {
    case heading, subHeading, paragraph, detail
}

struct CBText: View {
    
    let text: String
    let textType: TextType
    let alignment: Alignment
    let colorInverted: Bool
    
    init(text: String,
         textType: TextType,
         alignment: Alignment = .leading,
         colorInverted: Bool = false) {
        self.text = text
        self.textType = textType
        self.alignment = alignment
        self.colorInverted = colorInverted
    }
    
    var body: some View {
        switch textType {
        case .heading:
            heading
        case .subHeading:
            subHeading
        case .paragraph:
            paragraph
        case .detail:
            detail
        }
    }
    
    @ViewBuilder var heading: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(colorInverted ? Colors.background : Colors.text)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder var subHeading: some View {
        Text(text)
            .font(.body)
            .fontWeight(.semibold)
            .foregroundColor(colorInverted ? Colors.backgroundOffset : Colors.textSecondary)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder var paragraph: some View {
        Text(text)
            .font(.body)
            .foregroundColor(colorInverted ? Colors.background : Colors.text)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder var detail: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(colorInverted ? Colors.backgroundOffset : Colors.textSecondary)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}

struct CBText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CBText(text: "Heading", textType: .heading)
            CBText(text: "Sub Heading", textType: .subHeading)
            CBText(text: "Paragraph", textType: .paragraph)
            CBText(text: "Detail", textType: .detail)
        }
    }
}
