import Flutter
import UIKit
import Snappy

//@UIApplicationMain
@main
@objc class AppDelegate: FlutterAppDelegate {
    private var userCallbackApi: UserCallbackApi?
    private var snappyNativeCallbackApi: SnappyNativeCallbackApi?
    private var storedUser = User(name: "iOS User", age: 25, email: "ios@example.com")

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController

        userCallbackApi = UserCallbackApi(binaryMessenger: controller.binaryMessenger)

        UserApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: self)
        
        //snappy
        snappyNativeCallbackApi = SnappyNativeCallbackApi(binaryMessenger: controller.binaryMessenger)
        SnappyApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: self)

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate: SnappyApi {
    func getMaxCompressedLength() -> SnappyData {
        return SnappyData(data: nil)
    }

    func compress(data: SnappyData) -> SnappyResponse {

//        snappyUtil().compress(data: data.data ?? Data())
        var text = ""
        
//        测试
        /*if let fileURL = Bundle.main.url(forResource: "utf8_text_sample", withExtension: "snappy"),
               let compressedData = try? Data(contentsOf: fileURL) {
                do {
                    if #available(iOS 14, *) {
                        let decompressedData = try compressedData.uncompressedUsingSnappy()
                        text = String(data: decompressedData, encoding: .utf8) ?? ""
                        print("解压缩成功: \(text)")
                    } else {
                        // Fallback on earlier versions
                    }
                    
                } catch {
                    print("解压缩错误: \\(error)")
                }
            }*/
        
        if let typedData = data.data {
            let rawData = typedData.data  // 将 FlutterStandardTypedData 转为 Data

                    do {
                        if #available(iOS 14.0, *) {
                            let decompressedData = try rawData.uncompressedUsingSnappy()
//                            print("解压缩成功: \(decompressedData)")
                            
                            snappyNativeCallbackApi?.onUncompress(data: SnappyData(data: FlutterStandardTypedData(bytes: decompressedData)), completion: { result in
//                                print("Snappy compression result: \(result)")
                            })
                        } else {
//                            print("iOS 14 以下不支持")
                        }
                    } catch {
//                        print("解压缩错误: \(error)")
                    }
        }
        return SnappyResponse(
            success: true,
            message: "User saved successfully on iOS : \(text)",
            sd: SnappyData(data: nil)
        )
    }
}

extension AppDelegate: UserApi {
    func getUser() -> User {
        return storedUser
    }

    func saveUser(user: User) -> ApiResponse {
        storedUser = user

        userCallbackApi?.onUserChanged(user: storedUser) { _ in }

        return ApiResponse(
            success: true,
            message: "User saved successfully on iOS",
            user: storedUser
        )
    }
}





// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
