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
            LinkView(data: $preview.metadata)
                .frame(width: 300, height: 300)

            // receive textfield text editing notification (events) via NotificationCenter Publisher
            // thanks: https://github.com/Dimillian/MovieSwiftUI/blob/a51bbe2502851f6f3dcabf730b2f72318232fcc1/MovieSwift/MovieSwift/views/shared/field/SearchField.swift#L25-L28
            TextField($link, placeholder: Text("eg: apple.com"))
                .onReceive(
                    NotificationCenter.default
                        .publisher(for: UITextField.textDidChangeNotification)
                        .debounce(for: 0.5, scheduler: DispatchQueue.main),
                    perform: { self.preview.fetch(self.link) }
                )
                .textFieldStyle(.roundedBorder)
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
