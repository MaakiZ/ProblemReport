import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Configurar a janela principal
        window = UIWindow(frame: UIScreen.main.bounds)
        let listProblemsViewController = ListProblemsViewController()
        let navigationController = UINavigationController(rootViewController: listProblemsViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    // ...
    
}
