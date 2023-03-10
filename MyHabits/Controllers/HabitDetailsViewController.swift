//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Александр Хмыров on 12.07.2022.
//

import UIKit

protocol HabitDetailsViewControllerIsADelegate {
    func notifyNeedPopHabitDetailsViewController()
}

class HabitDetailsViewController: UIViewController {

    var progressCell: ProgressCollectionViewCell?

    private var indexHabitInArray: Int?

    private var nameHabit: String?

    private lazy var barButtonRight: UIBarButtonItem = {
        var barButtonRight = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(actionBarButtonRight))
        return barButtonRight
    }()

    private lazy var labelActivity: UILabel = {
        var labelActivity = UILabel()
        labelActivity.translatesAutoresizingMaskIntoConstraints = false
        labelActivity.text = "АКТИВНОСТЬ"
        return labelActivity
    }()

    private lazy var tableViewDate: UITableView = {
        var tableViewDate = UITableView()
        tableViewDate.translatesAutoresizingMaskIntoConstraints = false
        tableViewDate.delegate = self
        tableViewDate.dataSource = self
        tableViewDate.register(DatesTableViewCell.self, forCellReuseIdentifier: DatesTableViewCell.nameTableViewCell)
        tableViewDate.register( UITableViewCell.self, forCellReuseIdentifier: "Default")
        return tableViewDate
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.view.backgroundColor = UIColor(named: "customGrey" )
        [labelActivity, tableViewDate].forEach({ self.view.addSubview($0) })
        setupConstraints()
        self.navigationItem.rightBarButtonItem = barButtonRight
    }


    func setupHabitDetailsViewController(indexPith: IndexPath) {

        let habit: Habit = HabitsStore.shared.habits[indexPith.row - 1]
        nameHabit = habit.name

        if let name: String = self.nameHabit {
                  self.navigationItem.title = name
              }

        self.indexHabitInArray = indexPith.item - 1
    }

  
    func setupConstraints() {
        NSLayoutConstraint.activate ([
            self.labelActivity.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 14),
            self.labelActivity.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),

            self.tableViewDate.topAnchor.constraint(equalTo: self.labelActivity.bottomAnchor, constant: 14),
            self.tableViewDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableViewDate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableViewDate.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -14),
        ])
    }

    @objc func actionBarButtonRight() {
        let habitViewController = HabitViewController()

        habitViewController.delegatePop = self

        let navHabitViewController = UINavigationController(rootViewController: habitViewController)

        habitViewController.delegateWidth = self.progressCell

        self.present(navHabitViewController, animated: true)

        habitViewController.setupHabitViewController(habit: HabitsStore.shared.habits[indexHabitInArray!], indexHabit: indexHabitInArray!)
    }
}


extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DatesTableViewCell.nameTableViewCell, for: indexPath) as! DatesTableViewCell

        var arrayIndex:[Int] = []
        var dateIndex = HabitsStore.shared.dates.count - 1
        while dateIndex >= 0 {
            arrayIndex.append(dateIndex)
            dateIndex -= 1
        }

        cell.setupDatesTableViewCell(date: HabitsStore.shared.dates[arrayIndex[indexPath.row]], number: indexHabitInArray!, indexPath: indexPath, indexDate: arrayIndex[indexPath.row] )
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}


extension HabitDetailsViewController: HabitDetailsViewControllerIsADelegate {

    func notifyNeedPopHabitDetailsViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
