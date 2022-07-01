//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Хмыров on 01.07.2022.
//

import UIKit


class HabitViewController: UIViewController {

    private lazy var nameNewHabit: String = {
        return ""
    }()

    private lazy var buttonNavRight: UIBarButtonItem = {
        var buttonNavRight = UIBarButtonItem( title: "Сохранить", style: .bordered, target: self, action: #selector(actionButtonNavRight))
        return buttonNavRight
    }()

    private lazy var labelNameHabit: UILabel = {
        var labelNameHabit = UILabel()
        labelNameHabit.translatesAutoresizingMaskIntoConstraints = false
        labelNameHabit.text = "Название"
        return labelNameHabit
    }()

    private lazy var textFieldNameNewHabit: UITextField = {
        var textFieldNameNewHabit = UITextField()
        textFieldNameNewHabit.translatesAutoresizingMaskIntoConstraints = false
        textFieldNameNewHabit.delegate = self
        textFieldNameNewHabit.text = "Напишите новою привычку"
        textFieldNameNewHabit.textColor = .systemGray2
    //  textFieldNameNewHabit.backgroundColor = .systemGray6
        textFieldNameNewHabit.addTarget(self, action: #selector(actionTextFieldNameNewHabit), for: .editingChanged)
        return textFieldNameNewHabit
    }()

    private lazy var labelColor: UILabel = {
        let labelColor = UILabel()
        labelColor.translatesAutoresizingMaskIntoConstraints = false
        labelColor.text = "Цвет"
        return labelColor
    }()

    private lazy var colorView: ColorView = {
        var colorView = ColorView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.cornerRadius = 20
        colorView.backgroundColor = .yellow
        return colorView
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.title = "Создать"
        [labelNameHabit, textFieldNameNewHabit, labelColor, colorView].forEach({ self.view.addSubview($0) })
        self.navigationItem.rightBarButtonItem = buttonNavRight

        setupGesture()
        setupConstrains()
    }


    private func setupConstrains(){
        NSLayoutConstraint.activate([
            self.labelNameHabit.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 14),
            self.labelNameHabit.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:  14),


            self.textFieldNameNewHabit.topAnchor.constraint(equalTo: self.labelNameHabit.bottomAnchor, constant: 14),
            self.textFieldNameNewHabit.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),

            self.labelColor.topAnchor.constraint(equalTo: self.textFieldNameNewHabit.bottomAnchor, constant: 14),
            self.labelColor.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),

            self.colorView.topAnchor.constraint(equalTo: self.labelColor.bottomAnchor, constant: 14),
            self.colorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            self.colorView.widthAnchor.constraint(equalToConstant: 40),
            self.colorView.heightAnchor.constraint(equalToConstant: 40)


        ])
    }

    private func setupGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(actionGestureColorView))
        self.colorView.addGestureRecognizer(gesture)
    }

    @objc private func actionTextFieldNameNewHabit(_ textField: UITextField) {

        if textField.text != nil {
        self.nameNewHabit = textField.text!
        }
        print(nameNewHabit)
    }

    @objc private func actionButtonNavRight() {
        print("safe")

//        if nameNewHabit != "" && colorView.backgroundColor != nil {
//        let newHabit = Habit(name: self.nameNewHabit,
//                             date: <#T##Date#>,
//                             color: colorView.backgroundColor!)
//
//        let store = HabitsStore.shared
//        store.habits.append(newHabit)
//    }
    }

    @objc private func actionGestureColorView() {
        print("gesture")
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.title = "Выбери цвет привычки"
        colorPicker.selectedColor = .black
        present(colorPicker, animated: true)
    }

}

extension HabitViewController: UITextFieldDelegate, UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print(viewController.selectedColor)
        self.colorView.backgroundColor = viewController.selectedColor
    }

}

