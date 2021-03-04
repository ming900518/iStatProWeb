//
//  ViewController.swift
//  iStatProWeb
//
//  Created by 桐野ちさき on 3/3/21.
//

import UIKit
import WebKit
import Foundation

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    let webView = WKWebView()
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        view.addSubview(webView)
        let leftConstraint = NSLayoutConstraint(
            item: self.webView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1,
            constant: 0)
        let rightConstraint = NSLayoutConstraint(
            item: self.webView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .trailing,
            multiplier: 1,
            constant: 0)
        let topConstraint = NSLayoutConstraint(
            item: self.webView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        let bottomConstraint = NSLayoutConstraint(
            item: self.webView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)
        self.view.addConstraint(leftConstraint)
        self.view.addConstraint(rightConstraint)
        self.view.addConstraint(topConstraint)
        self.view.addConstraint(bottomConstraint)
        self.webView.frame = .zero
        self.webView.translatesAutoresizingMaskIntoConstraints = false
    }
    override func viewDidAppear(_ animated: Bool) {
        let controller = UIAlertController(title: "Connection Info", message: "Enter IP address.", preferredStyle: .alert)
        controller.addTextField { (textField) in
            textField.placeholder = "http://*Your IP*:4027"
            textField.text = Setting.getIP()
            textField.keyboardType = UIKeyboardType.URL
        }
        let okAction = UIAlertAction(title: "Done", style: .default) { action in
            Setting.saveIP(value: (controller.textFields?[0].text)!)
            let finishUp = "http://" + (controller.textFields?[0].text)! + ":4027"
            let distURL = URL(string: finishUp)
            let distRequest = URLRequest(url: distURL!)
            self.webView.load(distRequest)
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}

class Setting {

    private static let IP = "IPAddress" //重试次数

    static func getIP() -> String {
        return UserDefaults.standard.string(forKey: IP) ?? ""
    }

    static func saveIP(value: String) {
        UserDefaults.standard.set(value, forKey: IP)
    }

}
