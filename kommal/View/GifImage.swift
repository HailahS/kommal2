//
//  Untitled.swift
//  kommal
//
//  Created by hailah alsaudi on 24/06/1446 AH.
//

//
//  GifView.swift
//  GifView_SwiftUI
//
//  Created by Pedro Rojas on 16/08/21.
//
import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String
    private let width: CGFloat
    private let height: CGFloat

    init(_ name: String, width: CGFloat = 100, height: CGFloat = 100) {
        self.name = name
        self.width = 500
        self.height = 500
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false // يجعل الخلفية شفافة
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear

        if let url = Bundle.main.url(forResource: name, withExtension: "gif") {
            let data = try! Data(contentsOf: url)
            let htmlString = """
            <html>
            <head>
            <style>
                body {
                    margin: 0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    background-color: transparent;
                }
                img {
                    width: \(width)px;
                    height: \(height)px;
                }
            </style>
            </head>
            <body>
                <img src="data:image/gif;base64,\(data.base64EncodedString())" />
            </body>
            </html>
            """
            webView.loadHTMLString(htmlString, baseURL: nil)
        }

        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("Sp", width: 700, height: 700) // تعديل الحجم كما ترغب
    }
}
