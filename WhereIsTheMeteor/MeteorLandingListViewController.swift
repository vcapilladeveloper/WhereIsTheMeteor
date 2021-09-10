//
//  ViewController.swift
//  WhereIsTheMeteor
//
//  Created by Victor Capilla Developer on 8/9/21.
//

import UIKit
import CoreLocation.CLLocation

class MeteorLandingListViewController: UIViewController {
    
    private var viewModel: MeteorLandingListViewModel = MeteorLandingListViewModel(MeteorLandingRepository())
    let refreshControl = UIRefreshControl()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var filterControl: UISegmentedControl!
    
    @IBOutlet var yearPickerButton: UIButton!
    
    @IBAction func showYearPicker(_ sender: UIButton) {
        let pickerView = YearPickerView(frame: self.view.frame)
        let years: [String] = (viewModel.minimumYear..<2021).map{ "\($0)" }
        pickerView.setup(years)
        
        pickerView.saveActualValue = { [weak self] year in
            self?.loadingAnimation()
            if let intYear: Int = Int(year) {
                self?.viewModel.update(intYear)
                self?.setupYearButton()
            }
        }
        pickerView.defaultSelectedItem("\(viewModel.fetchDataYear)")
        self.view.addSubview(pickerView)
        self.view.bringSubviewToFront(pickerView)
    }
    
    @IBAction func changeFilter(_ sender: UISegmentedControl) {
        viewModel.update(viewModel.meteorLandingSortBy[sender.selectedSegmentIndex]) 
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupSegmentedControl()
        setupYearButton()
        viewModel.updateUI = { [weak self] in
            self?.updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        refreshTableView()
    }
    
    private func loadingAnimation() {
        refreshControl.programaticallyBeginRefreshing(in: tableView)
    }
    
    func updateUI() {
        self.tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Setup Table View
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // initializing the refreshControl
        tableView.refreshControl = refreshControl
        // add target to UIRefreshControl
        loadingAnimation()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
    }
    
    // MARK: Setup Segmented Control
    private func setupSegmentedControl() {
        for (index, time) in viewModel.meteorLandingSortBy.enumerated() {
            filterControl.setTitle("\(time)", forSegmentAt: index)
        }
    }
    
    // MARK: Setup YearButton
    func setupYearButton() {
        self.yearPickerButton.setTitle("\(viewModel.fetchDataYear)", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinator = segue.destination as? MapViewController {
            if let info = sender as? [String: Any] {
                if let coordinates = info["coordinates"] as? CLLocation {
                    destinator.coordinates = coordinates
                }
            }
        }
    }
}


// MARK: - UITableViewDelegate
extension MeteorLandingListViewController: UITableViewDelegate {
    @objc private func refreshTableView() {
        viewModel.fecthData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meteorLanding = viewModel.meteorLanding[indexPath.row]
        guard let latString = meteorLanding.reclat else { return }
        guard let lonString = meteorLanding.reclong else { return }
        if let latitude = Double(latString), let longitude = Double(lonString) {
            performSegue(withIdentifier: "loadMap", sender: ["coordinates": CLLocation(latitude: latitude, longitude: longitude)])
        }
    }
    
}

// MARK: - UITableViewDataSource
extension MeteorLandingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meteorLanding.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier,
                                                       for: indexPath) as? MeteorLandingTableViewCell else { return UITableViewCell() }
        let meteorLanding = viewModel.meteorLanding[indexPath.row]
        cell.configure(meteorLanding, isFavorite: viewModel.isFavorite(meteorLanding.id))
        cell.setFavoriteFunction = { [weak self] in
            self?.viewModel.addOrRemoveFavorite(meteorLanding.id)
        }
        return cell
        
    }
}

extension UIRefreshControl {
    func programaticallyBeginRefreshing(in tableView: UITableView) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
}
