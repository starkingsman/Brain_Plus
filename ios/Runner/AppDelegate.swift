import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      weak var registrar = self.registrar(forPlugin: "plugins")

              let factory = SetView(setData: registrar!.messenger())
              self.registrar(forPlugin: "BrainPlus")!.register(
                  factory,
                  withId: "BrainPlus")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
