//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var animationTime = 2.0 {
        didSet {
            timeLabel.text = String(format: "Time: %.2f", animationTime)
        }
    }
    lazy var timeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.1
        slider.maximumValue = 10.0
        slider.setValue(Float(animationTime), animated: true)
        slider.addTarget(self, action: #selector(changeAnimationTime), for: .touchUpInside)
        return slider
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        label.text = String(format: "Time: %.2f", animationTime)
        return label
    }()
    
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.distribution = .fillProportionally
        buttonStack.spacing = 30
        return buttonStack
    }()
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("LEFT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("RIGHT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
        return button
    }()
    lazy var upButton: UIButton = {
        let button = UIButton()
        button.setTitle("UP", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
        let button = UIButton()
        button.setTitle("DOWN", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
    }
    @IBAction func changeAnimationTime() {
        animationTime = Double(timeSlider.value)
    }
    
    @IBAction func animateSquareLeft(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset - 50
        UIView.animate(withDuration: self.animationTime) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func animateSquareRight(sender: UIButton) {
        let oldOffset = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffset + 50
        UIView.animate(withDuration: self.animationTime) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - 50
        
        UIView.animate(withDuration: self.animationTime) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        let timeInterval = TimeInterval(animationTime)
        dump(timeInterval)
        blueSquareCenterYConstraint.constant = oldOffet + 50
        UIView.animate(withDuration: self.animationTime) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        addSliderSubviews()
        addLabelSubviews()
        view.addSubview(buttonStackView)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(leftButton)
        buttonStackView.addSubview(rightButton)
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
    }
    private func addSliderSubviews() {
        view.addSubview(timeSlider)
    }
    private func addLabelSubviews() {
        view.addSubview(timeLabel)
    }
    private func configureConstraints() {
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
        constraintLeftButton()
        constraintRightButton()
        constrainButtonStackView()
        constraintSlider()
        constraintsLabel()
    }
    private func constraintsLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    private func constraintSlider() {
        timeSlider.translatesAutoresizingMaskIntoConstraints = false
        timeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeSlider.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.80).isActive = true
        timeSlider.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
    }
    private func constraintLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: downButton.trailingAnchor).isActive = true
    }
    private func constraintRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: upButton.leadingAnchor).isActive = true
        rightButton.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor).isActive = true
    }
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        upButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}


