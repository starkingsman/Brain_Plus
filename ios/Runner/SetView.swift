import Flutter
import UIKit
import WebKit
class SetView: NSObject, FlutterPlatformViewFactory {
    private var setData: FlutterBinaryMessenger

    init(setData: FlutterBinaryMessenger) {
        self.setData = setData
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView
     {
         return SetViewState(frame, viewId: viewId, args: args, binaryMessenger: self.setData)
     }
     
     func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol
     {
         return FlutterStandardMessageCodec.sharedInstance()
     }
}

class SetViewState: NSObject, FlutterPlatformView, WKUIDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugPrint("==native: " + message.name + ":" + _fName)
        if message.name == _fName {
            if let msg = message.body as? String {
                debugPrint("===: " + msg)
                _flutterChannel?.invokeMethod("nativeToFlutter", arguments: msg, result: { (_result) in
                    debugPrint("===" )
                })
            }
        }
    }
    
    
    private var _showView: UIView?
    var _flutterChannel: FlutterMethodChannel?
    var _appkey: String = "BrainPlus"
    var _fName: String = "function"
    var _url:URL
    var _myView:WKWebView
    
    init(_ frame: CGRect, viewId: Int64, args :Any?, binaryMessenger: FlutterBinaryMessenger)
    {
        _myView = WKWebView()
        _showView = UIView()
        let dict = args as? NSDictionary
        _appkey = dict?.value(forKey: "key") as! String ?? _appkey
        _fName = dict?.value(forKey: "function") as! String ?? _fName
        _url = URL(string: _appkey)!
        super.init()
        
        
        _flutterChannel = FlutterMethodChannel(name: "BrainPlus", binaryMessenger: binaryMessenger)
        _flutterChannel?.setMethodCallHandler { (call: FlutterMethodCall, result:@escaping FlutterResult) in
            if (call.method == "flutterToNative") {
                debugPrint("== flutterToNative: ")
                self._myView.load(URLRequest(url: self._url))
                
            }
        }
        
    }
    
    func view() -> UIView {
        let contentController = WKUserContentController();
        contentController.add(self, name: _fName)
        
        let config = WKWebViewConfiguration();
        config.userContentController = contentController;
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        config.preferences = preferences
        _myView = WKWebView(frame: .zero, configuration: config);
        
        _myView.uiDelegate = self

        _myView.load(URLRequest(url: _url))
        return _myView
    }
    
}
