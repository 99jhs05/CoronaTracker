//
//  NewsView.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-24.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: View{
    
    var url: String
    @ObservedObject var webModel: WebViewModel
    
    init(url: String){
        self.url = url
        webModel = WebViewModel(url: url)
    }
    
    var body: some View{
        
        VStack{
            WebViewWithIndicator(isShowing: self.$webModel.isLoading){
                WebViewBase(viewModel: self.webModel)
            }
            AdBannerView().frame(width: UIScreen.main.bounds.width, height: 60)
        }
    }
}

struct WebViewWithIndicator<Content>: View where Content: View{
    
    @Binding var isShowing: Bool
    var content: ()->Content
    
    var body: some View{
        ZStack(alignment: .center){
            self.content()
            Loader()
                .opacity(self.isShowing ? 1 : 0)
        }
    }
}

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true

    init (url: String) {
        self.url = url
    }
}
  
struct WebViewBase : UIViewRepresentable {
    
    static var cache = [URL:WKWebView]()
    @ObservedObject var viewModel: WebViewModel

    func makeCoordinator() -> Coordinator {
        Coordinator(self.viewModel)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private var viewModel: WebViewModel

        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.isLoading = false
        }
        
//        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
//
//            switch navigationAction.navigationType {
//            case .linkActivated:
//                UIApplication.shared.open(navigationAction.request.url!)
//                decisionHandler(.cancel)
//                return
//            default:
//                break
//            }
//            decisionHandler(.allow)
//        }
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebViewBase>) { }

    func makeUIView(context: Context) -> UIView {

        guard let url = URL(string: self.viewModel.url) else { fatalError() }

        if let webView = WebViewBase.cache[url] {
            return webView
        }
        
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        webView.load(URLRequest(url: url))
        WebViewBase.cache[url] = webView
        
        return webView
    }
    
}
