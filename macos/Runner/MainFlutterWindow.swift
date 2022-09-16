import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    
    var methodChannel: FlutterMethodChannel!
    
  override func awakeFromNib() {
    let viewController = BlurViewController.init()
    let windowFrame = self.frame
    self.contentViewController = viewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: viewController.flutterViewController)
      
      
      self.methodChannel = FlutterMethodChannel.init(name: "jernal", binaryMessenger: viewController.flutterViewController.engine.binaryMessenger)
      
    self.isMovableByWindowBackground = true
    super.awakeFromNib()
  }
    
}

class BlurViewController: NSViewController {
    let flutterViewController = FlutterViewController()
    override func loadView() {
       let blurView = NSVisualEffectView()
       blurView.autoresizingMask = [.width, .height]
       blurView.blendingMode = .behindWindow
       blurView.state = .active
       if #available(macOS 10.14, *) {
           blurView.material = .sidebar
       }
       self.view = blurView
     }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()

      self.addChild(flutterViewController)

      flutterViewController.view.frame = self.view.bounds
      flutterViewController.view.autoresizingMask = [.width, .height]
      self.view.addSubview(flutterViewController.view)
    }
}
