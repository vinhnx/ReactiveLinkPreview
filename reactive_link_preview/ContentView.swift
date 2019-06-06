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
            TextField($link, placeholder: Text("...enter some link, eg: https://apple.com")) {
                self.preview.fetch(self.link)
            }

            Text("\(preview.metadata.title ?? "...")")
        }
    }
}

final class LinkPreviewData: BindableObject {
    internal let didChange = PassthroughSubject<LinkPreviewData, Never>()
    public private(set) var metadata = LPLinkMetadata() {
        didSet {
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }
    }

    func fetch(_ urlString: String) {
        let url = URLBuilder.build(urlString)
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { metadata, error in
            if let _ = error { return }
            guard let metadata = metadata else { return }
            self.metadata = metadata
        }
    }
}

struct URLBuilder {
    static func build(_ urlString: String) -> URL {
        let https = "https://"
        if urlString.hasPrefix(https) {
            return URL(string: urlString)!
        }

        return URL(string: (https + urlString))!
    }
}
