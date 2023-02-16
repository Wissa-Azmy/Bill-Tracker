//
//  Sheet.swift
//  Expenser
//
//  Created by Wissa.Michael on 16.02.23.
//

import SwiftUI

struct Sheet<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode

    var title: String = ""
    var dismissButtonTitle = ""
    var dismissAction: (() -> Void)?
    @ViewBuilder var content: Content

    init(
        title: String = "",
        dismissButtonTitle: String = "",
        dismissAction: (() -> Void)? = nil,
        @ViewBuilder _ content: () -> Content
    ) {
        self.title = title
        self.dismissButtonTitle = dismissButtonTitle
        self.dismissAction = dismissAction
        self.content = content()
    }

    var body: some View {
        NavigationView {
            content
                .navigationTitle(title)
                .navigationBarItems(trailing: Button(dismissButtonTitle) {
                    dismissAction?()
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}
