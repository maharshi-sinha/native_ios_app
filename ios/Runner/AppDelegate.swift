import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: "examples.ios/native_ios_app",
                                                 binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if call.method == "addNumbers" {
                guard let args = call.arguments as? [String: Any],
                      let num1 = args["num1"] as? Int,
                      let num2 = args["num2"] as? Int else {
                    result(FlutterError(code: "INVALID_ARGUMENTS",
                                        message: "Invalid arguments for method: addNumbers",
                                        details: nil))
                    return
                }
                self?.addNumbers(num1: num1, num2: num2, result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    private func addNumbers(num1: Int, num2: Int, result: FlutterResult) {
        let sum = num1 + num2
        result(sum)
    }
}
