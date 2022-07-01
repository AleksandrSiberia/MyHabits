//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Хмыров on 30.06.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var buttonAddHabit: UIButton = {
        var buttonAddHabit = UIButton()
        buttonAddHabit.translatesAutoresizingMaskIntoConstraints = false
        buttonAddHabit.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonAddHabit.addTarget(self, action: #selector(actionButtonAddHabit), for: .touchUpInside )
        return buttonAddHabit
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(buttonAddHabit)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.buttonAddHabit.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.buttonAddHabit.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),
            self.buttonAddHabit.widthAnchor.constraint(equalToConstant: 40),
            self.buttonAddHabit.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func actionButtonAddHabit() {

        let navHabitViewController = UINavigationController(rootViewController: HabitViewController())

        self.navigationController?.present(navHabitViewController, animated: true)
    }


}

