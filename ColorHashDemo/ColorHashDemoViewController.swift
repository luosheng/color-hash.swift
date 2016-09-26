//
//  ColorHashDemoViewController.swift
//  ColorHashDemo
//
//  Created by Atsushi Nagase on 11/25/15.
//  Copyright © 2015 LittleApps Inc. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
    class ColorHashDemoViewController: UIViewController, UITextFieldDelegate {
        @IBOutlet weak var textField: UITextField!
        @IBOutlet weak var saturationSlider: UISlider!
        @IBOutlet weak var brightnessSlider: UISlider!
        @IBOutlet weak var saturationLabel: UILabel!
        @IBOutlet weak var brightnessLabel: UILabel!

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let nsString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            updateBackgroundColor(nsString)
            return true
        }
    }
#elseif os(OSX)
    import Cocoa
    class ColorHashDemoViewController: NSViewController, NSTextFieldDelegate {
        @IBOutlet weak var textField: NSTextField!
        @IBOutlet weak var saturationSlider: NSSlider!
        @IBOutlet weak var brightnessSlider: NSSlider!
        @IBOutlet weak var saturationLabel: NSTextField!
        @IBOutlet weak var brightnessLabel: NSTextField!

        override func controlTextDidChange(_ obj: Notification) {
            updateBackgroundColor()
        }
    }
#endif

extension ColorHashDemoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let def = UserDefaults.standard
        def.register(defaults: ["str": "Hello World", "s": 0.5, "l": 0.5 ])
        #if os(iOS) || os(tvOS)
            textField.text = def.string(forKey: "str")
            saturationSlider.value = def.float(forKey: "s")
            brightnessSlider.value = def.float(forKey: "l")
        #elseif os(OSX)
            textField.stringValue = def.string(forKey: "str") ?? ""
            saturationSlider.floatValue = def.float(forKey: "s")
            brightnessSlider.floatValue = def.float(forKey: "l")
        #endif
        updateBackgroundColor()
    }
    @IBAction func sliderValueChanged(_ sender: AnyObject) {
        updateBackgroundColor()
    }

    fileprivate func updateBackgroundColor(_ str: String? = nil) {
        var str = str
        #if os(iOS) || os(tvOS)
            let s = saturationSlider.value
            let l = brightnessSlider.value
            str = str ?? textField.text!
        #elseif os(OSX)
            let s = saturationSlider.floatValue
            let l = brightnessSlider.floatValue
            str = str ?? textField.stringValue
        #endif
        self.setBackgroundColor(c: ColorHash(str!, [CGFloat(s)], [CGFloat(l)]).color)
        setLabelText(label: saturationLabel, text: "Saturation\n\(s)")
        setLabelText(label: brightnessLabel, text: "Brightness\n\(l)")
        let def = UserDefaults.standard
        def.set(s, forKey: "s")
        def.set(l, forKey: "l")
        def.setValue(str, forKey: "str")
        def.synchronize()
    }

    #if os(iOS) || os(tvOS)
    fileprivate func setBackgroundColor(c: UIColor) {
        self.view.backgroundColor = c
    }

    fileprivate func setLabelText(label: UILabel, text: String) {
        label.text = text
    }
    #elseif os(OSX)
    fileprivate func setBackgroundColor(_ c: NSColor) {
        let layer = CALayer()
        layer.backgroundColor = c.cgColor
        view.wantsLayer = true
        view.layer = layer
    }

    fileprivate func setLabelText(_ label: NSTextField, text: String) {
        label.stringValue = text
    }
    #endif
}

