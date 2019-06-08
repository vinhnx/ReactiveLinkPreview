//
//  LinkPreviewData.swift
//  reactive_link_preview
//
//  Created by Vinh Nguyen on 8/6/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Combine
import Foundation
import LinkPresentation
import SwiftUI

final class LinkPreviewData: BindableObject {
    let didChange = PassthroughSubject<LinkPreviewData, Never>()
    var metadata = LPLinkMetadata() {
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
            guard error == nil else { return }
            guard let metadata = metadata else { return }
            self.metadata = metadata
        }
    }
}
