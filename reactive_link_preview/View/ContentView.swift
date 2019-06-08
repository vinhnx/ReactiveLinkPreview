//
//  ContentView.swift
//  reactive_link_preview
//
//  Created by Vinh Nguyen on 6/6/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Combine
import LinkPresentation
import SwiftUI

struct LinkDisplayView: View {
    @EnvironmentObject var preview: LinkPreviewData
    @State var link = ""

    var body: some View {
        VStack {
            TextField($link, placeholder: Text("...enter some link, eg: apple.com, then press enter")) {
                self.preview.fetch(self.link)
            }

            LinkView(data: $preview.metadata)
                .frame(width: 300, height: 300)
        }.padding()
    }
}

struct LinkView: UIViewRepresentable {
    @Binding var data: LPLinkMetadata

    func makeUIView(context: Context) -> LPLinkView {
        LPLinkView(metadata: self.data)
    }

    func updateUIView(_ view: LPLinkView, context: Context) {
        view.metadata = self.data
    }
}
