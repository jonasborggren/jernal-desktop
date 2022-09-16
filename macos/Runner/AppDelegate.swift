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
        status?.button?.title = "Jernal"
        status?.button?.target = self
        status?.button?.action = #selector(self.statusBarButtonClicked(_:))
        //status?.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
        
        let open = NSMenuItem(title: "Open", action: #selector(self.openWindow), keyEquivalent: "")
        let prefs = NSMenuItem(title: "Preferences", action: #selector(self.openPreferences), keyEquivalent: "")
        let quit = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "")
        
        let menu = NSMenu.init()
        menu.addItem(open)
        menu.addItem(prefs)
        menu.addItem(quit)
        
        status?.menu = menu
    }
    
    @IBAction func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        if let menu = self.status.menu {
            status?.popUpMenu(menu)
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

