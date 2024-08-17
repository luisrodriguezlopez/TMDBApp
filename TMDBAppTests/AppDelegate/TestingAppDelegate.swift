import UIKit
@objc(TestingAppDelegate)
class TestingAppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("<< Launching with testing app delegate")
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            sceneConfiguration.delegateClass = TestingSceneDelegate.self
            sceneConfiguration.storyboard = nil

            return sceneConfiguration
        }
}
