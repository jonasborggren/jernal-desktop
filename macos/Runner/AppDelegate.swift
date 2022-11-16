import Cocoa
import FlutterMacOS
import SwiftUI

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        NSApp.setActivationPolicy(.accessory)
        return false
    }
    
    var status: NSStatusItem!
    
    override func applicationDidFinishLaunching(_ notification: Notification) {
        status = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        status?.button?.image = NSImage(named:NSImage.Name("StatusBarIcon"))
        status?.button?.target = self
        status?.button?.action = #selector(self.statusBarButtonClicked(_:))
        
        let open = NSMenuItem(title: "Open", action: #selector(self.openWindow), keyEquivalent: "")
        let prefs = NSMenuItem(title: "Preferences", action: #selector(self.openPreferences), keyEquivalent: "")
        let quit = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "")
        
        let menu = NSMenu.init()
        menu.addItem(open)
        menu.addItem(prefs)
        menu.addItem(quit)
        
        status?.menu = menu
        
        DispatchQueue.main.async {
            let window = NSApp.windows.first as? MainFlutterWindow?
            
            window??.methodChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                let args = self.getArgs(call.arguments)
                switch call.method {
                case "theme_mode":
                    let mode = args["mode"] as? String
                    switch (mode) {
                        case "dark":
                            window??.appearance = NSAppearance(named: .darkAqua)
                            break;
                        case "light":
                            window??.appearance = NSAppearance(named: .aqua)
                            break;
                        case "system":
                            window??.appearance = NSAppearance()
                            break
                        case .none: break
                        case .some(_): break;
                    }
                    break;
                default:
                    result(FlutterMethodNotImplemented)
                }
            })
        }
    }
    
    public func getArgs(_ arguments: Any?) -> [String: Any?] {
        guard let arguments = arguments as? [String: Any?] else {
            return [:]
        }
        return arguments
    }
    
    @IBAction func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        if let menu = self.status.menu {
            status?.menu = menu
            status?.button?.performClick(nil)
            status?.menu = nil
        }
    }
    
    @objc func openWindow() {
        NSApp.setActivationPolicy(.regular)
        DispatchQueue.main.async {
            NSApp.windows.first?.orderFrontRegardless()
        }
    }
    
    @objc func openPreferences() {
        NSApp.setActivationPolicy(.regular)
        DispatchQueue.main.async {
            NSApp.windows.first?.orderFrontRegardless()
            let window = NSApp.windows.first as? MainFlutterWindow?
            window??.methodChannel.invokeMethod("navigate", arguments: "preferences")
        }
    }
}

