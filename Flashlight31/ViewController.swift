//
//  ViewController.swift
//  Flashlight31
//
//  Created by jdcorn on 12/9/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: - Properties
    var isOn: Bool = true

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isOn { // If light is on
            return .lightContent // Turn on dark status label
        } else {
            return .darkContent // Turn on light status label
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var onbuttonToggled: UIButton!
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    /// This is the button's action funcion
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        sender.addTarget(self, action: #selector(onbuttonTapped(_:)))
    }
    
    
    @IBAction func onbuttonTapped(_ sender: Any) {

        /// If isOn  -> { do what's in this scope }
        /// when this button is tapped, first check which state the property "isOn" is in
        /// if isOn...
        if isOn {

            /// is off
            self.isOn = false
            /// change the button text to "On"
            self.onbuttonToggled.setTitle("Turn Off", for: .normal)
            /// and the button text color to black
            self.onbuttonToggled.setTitleColor(.black, for: .normal)
            /// and change the view bg color to white
            self.view.backgroundColor = .white
            /// function that updates status bar appearance
            setNeedsStatusBarAppearanceUpdate()
            /// device flashlight
            toggleTorch(on: true)
            

            /// When this scope has finished running, our view will have a white background with a button that reads "On"

        /// else, run this scope
        } else {

            /// is On
            self.isOn = true
            /// change the button text to "Off"
            self.onbuttonToggled.setTitle("Turn On", for: .normal)
            /// and the button text color to white
            self.onbuttonToggled.setTitleColor(.white, for: .normal)
            /// and change the view bg color to black
            self.view.backgroundColor = .black
            /// function that updates status bar appearance
            setNeedsStatusBarAppearanceUpdate()
            /// device flashlight
            toggleTorch(on: false)

            /// When this scope has finished running, our view will have a white background with a button that reads "Off"

        }
    }

    // MARK: - Functions
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}
