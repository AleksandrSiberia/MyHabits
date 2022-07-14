//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Хмыров on 01.07.2022.
//

import UIKit


class HabitViewController: UIViewController {

    private lazy var indexHabitInArray: Int = {
        var numberHabitInArray = Int()
        return numberHabitInArray
    }()

    private lazy var nameNewHabit: String? = {
        var nameNewHabit: String?
        return nameNewHabit
    }()

    private lazy var dateNewHabit: Date? = {
        var dateNewHabit: Date?
        return dateNewHabit
    }()

    private lazy var buttonNavRight: UIBarButtonItem = {
        var buttonNavRight = UIBarButtonItem( title: "Сохранить", style: .plain, target: self, action: #selector(actionButtonNavRight))
        return buttonNavRight
    }()

    private lazy var labelNameHabit: UILabel = {
        var labelNameHabit = UILabel()
        labelNameHabit.translatesAutoresizingMaskIntoConstraints = false
        labelNameHabit.text = "Напишите название привычки"
        return labelNameHabit
    }()

    private lazy var textFieldNameNewHabit: UITextField = {

        var textFieldNameNewHabit = UITextField()
        textFieldNameNewHabit.translatesAutoresizingMaskIntoConstraints = false
        textFieldNameNewHabit.delegate = self
        textFieldNameNewHabit.textColor = .black
        textFieldNameNewHabit.backgroundColor = .systemGray6
        textFieldNameNewHabit.layer.cornerRadius = 10
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

    private lazy var labelDate: UILabel = {
        var labelDate = UILabel()
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.text = "Задайте время"
        return labelDate
    }()

    private lazy var labelEveryday: UILabel = {
        var labelEveryday = UILabel()
        labelEveryday.translatesAutoresizingMaskIntoConstraints = false
        labelEveryday.text = "Каждый день в"
        return labelEveryday
    }()

    private lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(actionDatePicker), for: .valueChanged)
        return datePicker
    }()

    private lazy var buttonDelateHabit: UIButton = {
        var buttonDelateHabit = UIButton()
        buttonDelateHabit.translatesAutoresizingMaskIntoConstraints = false
        buttonDelateHabit.setTitle("Удалить привычку", for: .normal)
        buttonDelateHabit.setTitleColor(UIColor.red, for: .normal)
        buttonDelateHabit.addTarget(self, action: #selector(actionButtonDelateHabit), for: .touchUpInside)
        buttonDelateHabit.isHidden = true
        return buttonDelateHabit
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.title = "Создать"
        [labelNameHabit, textFieldNameNewHabit, labelColor, colorView, labelDate, labelEveryday, datePicker, buttonDelateHabit].forEach({ self.view.addSubview($0) })
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
            self.textFieldNameNewHabit.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),

            self.labelColor.topAnchor.constraint(equalTo: self.textFieldNameNewHabit.bottomAnchor, constant: 14),
            self.labelColor.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),

            self.colorView.topAnchor.constraint(equalTo: self.labelColor.bottomAnchor, constant: 14),
            self.colorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            self.colorView.widthAnchor.constraint(equalToConstant: 40),
            self.colorView.heightAnchor.constraint(equalToConstant: 40),

            self.labelDate.topAnchor.constraint(equalTo: self.colorView.bottomAnchor, constant: 14),
            self.labelDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),

            self.labelEveryday.topAnchor.constraint(equalTo: self.labelDate.bottomAnchor, constant: 14),
            self.labelEveryday.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),

            self.datePicker.leadingAnchor.constraint(equalTo: self.labelEveryday.trailingAnchor, constant: 7),
            self.datePicker.centerYAnchor.constraint(equalTo: self.labelEveryday.centerYAnchor),

            self.buttonDelateHabit.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -14),
            self.buttonDelateHabit.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }

    func setupHabitViewController(habit: Habit, indexHabit: Int) {
        self.textFieldNameNewHabit.text = habit.name
        self.colorView.backgroundColor = habit.color
        self.datePicker.date = habit.date
        self.indexHabitInArray = indexHabit
        self.buttonDelateHabit.isHidden = false

        self.buttonNavRight = UIBarButtonItem(title: "Сохранить2", style: .plain, target: self, action: #selector(actionResaveButtonNavRight))
    }

    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(actionGestureColorView))
        self.colorView.addGestureRecognizer(gesture)
    }

    @objc private func actionTextFieldNameNewHabit(_ textField: UITextField) {

        if textField.text != nil {
        self.nameNewHabit = textField.text!
        print(nameNewHabit!)
        }
    }

    @objc private func actionDatePicker() {
        self.dateNewHabit = datePicker.date
        print(dateNewHabit!)
    }

    @objc private func actionButtonNavRight() {

        if nameNewHabit != nil && colorView.backgroundColor != nil && dateNewHabit != nil  {
        let newHabit = Habit(name: self.nameNewHabit!,
                             date: self.dateNewHabit!,
                             color: self.colorView.backgroundColor!)
        let store = HabitsStore.shared
            store.habits.insert(newHabit, at: 0)
        print(newHabit)
        let habitsViewController = HabitsViewController()
        habitsViewController.reloadCollectionViewHabits()
        self.dismiss(animated: true)
        }
        else if nameNewHabit == nil || dateNewHabit == nil {
            print("Заполните все обязательные поля")
    }
    }


    @objc private func actionResaveButtonNavRight() {
        let editedHabit = HabitsStore.shared.habits.remove(at: indexHabitInArray)

        if self.colorView.backgroundColor != nil && self.textFieldNameNewHabit.text != nil {
        editedHabit.color = self.colorView.backgroundColor!
        editedHabit.date = self.datePicker.date
        editedHabit.name = self.textFieldNameNewHabit.text!
        }
        HabitsStore.shared.habits.insert(editedHabit, at: indexHabitInArray)

        let habitsViewController = HabitsViewController()
        habitsViewController.reloadCollectionViewHabits()
        self.dismiss(animated: true)
    }


    @objc private func actionGestureColorView() {
        print("gesture")
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.title = "Выбери цвет привычки"
        colorPicker.selectedColor = .black
        present(colorPicker, animated: true)
    }

    @objc private func actionButtonDelateHabit() {

        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку - \(HabitsStore.shared.habits[indexHabitInArray].name) ", preferredStyle: .alert)

        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("cancel")
        }
        alert.addAction(actionCancel)


        let actionDelete = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.remove(at: self.indexHabitInArray)

            let habitDetailsViewController = HabitDetailsViewController()
            habitDetailsViewController.dismiss(animated: true)
            
            self.dismiss(animated: true)

        }
        alert.addAction(actionDelete)

        present(alert, animated: true)


    }
}

extension HabitViewController: UITextFieldDelegate, UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print(viewController.selectedColor)
        self.colorView.backgroundColor = viewController.selectedColor
    }
}

