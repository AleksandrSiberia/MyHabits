//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Александр Хмыров on 30.06.2022.
//

import UIKit


class InfoViewController: UIViewController {

    private lazy var scrollViewInfo: UIScrollView = {
        var scrollViewInfo = UIScrollView()
        scrollViewInfo.translatesAutoresizingMaskIntoConstraints = false
        scrollViewInfo.backgroundColor = .systemBackground
        return scrollViewInfo
    }()

    private lazy var stackViewInfo: UIStackView = {
        var stackViewInfo = UIStackView()
        stackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        stackViewInfo.axis = .vertical
        return stackViewInfo
    }()

    private lazy var labelInfo: UILabel = {
        var labelInfo = UILabel()
        labelInfo.text = "Привычка за 21 день"
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        return labelInfo
    }()

    private lazy var labelTextInfo: UILabel = {
        var labelTextInfo = UILabel()
        labelTextInfo.numberOfLines = 0
        labelTextInfo.translatesAutoresizingMaskIntoConstraints = false
        labelTextInfo.text = "УРОВЕНЬ ВИТАМИНА D В КРОВИ ВЫШЕ 30 нг/мл даёт максимальную абсорбцию кальция и снижение уровня ПТГ в кишечнике, защищая так от рахита, остеопороза и оптимизирует развитие и функционирование нейронов коры головного мозга. Поддержите УРОВЕНЬ ВЫШЕ 50 нг/мл дополнительно к вышесказанному эффективно защищает от набора лишнего веса, так как приостанавливается рост новых жировых клеток (адипоцитов).При этом уровне также снижается заболеваемость раком в целом на 75%,  так как Витамин D воздействует на гены иммунных клеток через VDR рецепторы, стимулируя синтез их белков. Снижается заболеваемость диабетом 1-го типа на 80% и 2-го на 50%, так как старые жировые клетки заменяются на новые, которые более чувствительны к инсулину, нормализуется работа бета клеток поджелудочной железы, ткани организма становятся более чувствительны к инсулину и инсулин с глюкозой начинают лучше заходить в клетки, поэтому уровень глюкозы (сахара) в крови естественно снижается. Снижается инфаркт миокарда на 50%, заболеваемость сосудов на 80%, так как Витамин D через VDR снижает выработку Регина, повышающего артериальное давление, и стимулирует производство оксида азота в эндотелиальных клетках кровеносных сосудов, повышая этим их функциональность. Снижает рассеянный склероз на 50%, так как Витамин D уменьшает концентрации холестерина и триглицеридов, из которых формируются бляшки в сосудах, и снижает выработку циклооксигеназы и СРБ, уменьшая этим воспалительные процессы, приводящие к атеросклерозу. Снижается риск кесарева сечения на 75%. УРОВЕНЬ 75-100 нг/мл плюс ко всему является эффективным уровнем для лечения ожирения и сахарного диабета.     УРОВЕНЬ 100-120 нг/мл плюс к вышесказанному замедляет старение (anti-aging effect) и не токсичен для организма.    БЕЗОПАСНЫЙ УРОВЕНЬ ДО 150 нг/мл      УРОВЕНЬ 150-180 нг/мл - коридор, который врачи стараются не преодолевать.     ЦЕЛЕВОЕ ЗНАЧЕНИЕ 65-100 нг/мл. Уровни с 65 до 100 нг/мл являются референтными значениями, то есть это среднии показатели уровня Витамина D, которые были у здоровых людей при анализе, поэтому рекомендовано их поддерживать. Российская ассоциация эндокринологов считает нормальными уровнями 30-100 нг/мл. "

        return labelTextInfo
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.title = "Информация"
        [scrollViewInfo].forEach({ self.view.addSubview($0)})
        self.scrollViewInfo.addSubview(stackViewInfo)
        self.stackViewInfo.addSubview(self.labelInfo)
        self.stackViewInfo.addSubview(self.labelTextInfo)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.scrollViewInfo.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollViewInfo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollViewInfo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollViewInfo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.stackViewInfo.topAnchor.constraint(equalTo: self.scrollViewInfo.topAnchor),
            self.stackViewInfo.widthAnchor.constraint(equalTo: self.scrollViewInfo.widthAnchor),
            self.stackViewInfo.bottomAnchor.constraint(equalTo: self.scrollViewInfo.bottomAnchor),

            self.labelInfo.topAnchor.constraint(equalTo: self.stackViewInfo.topAnchor),

            self.labelTextInfo.topAnchor.constraint(equalTo: self.labelInfo.bottomAnchor, constant: 14),
            self.labelTextInfo.widthAnchor.constraint(equalTo: self.stackViewInfo.widthAnchor),
            self.labelTextInfo.bottomAnchor.constraint(equalTo: self.stackViewInfo.bottomAnchor)
        ])
    }


}
