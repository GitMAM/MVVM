
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let appController = AppController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appController.appDidFinishLaunching(with: window)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        appController.appDidBecomeActive()
    }
}

