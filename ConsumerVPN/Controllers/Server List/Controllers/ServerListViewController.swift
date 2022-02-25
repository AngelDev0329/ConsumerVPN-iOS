//
//  ServerListViewController.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/15/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import UIKit
import VPNKit

final class ServerListViewController: BaseServerTableViewController {
    
    // MARK: Types
    enum RestorationKeys: String {
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
    }
    
    struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }

    // MARK: IBOutlets and Variables
    /// Button which brings the user to the filter and sorting options for the servers
    @IBOutlet weak var filterButton: UIBarButtonItem!
    /// Button which makes the search bar the first responder for searching
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    
    // VPNKit Properties
    var apiManager: VPNAPIManager! {
        didSet {
            vpnConfiguration = apiManager.vpnConfiguration
        }
    }

    var vpnConfiguration: VPNConfiguration?
    
    /// Array consisting of ALL City objects transformed into CityModel objects.
    fileprivate var cityModels: [CityModel] = []
    
    /// Array consisting of the sorted and filtered CityModel objects
    fileprivate var sortedModels: [CityModel] = [] {
        didSet {
            // Display the Empty state view if there are no values when there used to be
            if sortedModels.count == 0 { // display empty state
                emptyStateView.isHidden = false
            } else if sortedModels.count != 0 { // remove the empty state
                emptyStateView.isHidden = true
            }
        }
    }
    
    // Sort Options
    fileprivate var sortOption = SortOption.country
    
    // All Sort options. This will be passed forward to FilterViewController
    fileprivate let fSortByOptions: [SortOption] = [.city, .country]

    // Searching Behavior
    fileprivate var searchController: UISearchController!
    /// Used to display the filtered search results using the SearchController
    fileprivate var resultsServerViewController: ResultsServerViewController!
    fileprivate var restoredState = SearchControllerRestorableState()
    
    /// View which contains information on why the user is looking at an empty state on the table view and acts as the background when the `filteredModels` array contains 0 elements
    fileprivate var emptyStateView: EmptyStateView!
    /// Used to determine if the reloadServers button on the Empty state view has been pressed and if so, display the status of the servers updating
    fileprivate var serverUpdatePressed = false
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // assign our remembered info about sorting from NSUserDefaults
        sortOption = fSortByOptions[UserDefaults.standard.integer(forKey: Theme.sortOptionKey)]
        
        // setup accessibility and localization
        setupAccessibilityAndLocalization()
        
        // Setup the Empty State View
        if let emptyStateView = Bundle.main.loadNibNamed(EmptyStateView.nibName, owner: self, options: nil)?.first as? EmptyStateView {
            // configure the empty state view visually
            emptyStateView.frame = tableView.frame
            emptyStateView.isHidden = true
            tableView.backgroundView = emptyStateView
            // assign its delegate
            emptyStateView.delegate = self
            // keep a strong reference to it
            self.emptyStateView = emptyStateView
        }
        
        // Create and setup the Results View Controller where our search results will be displayed
        resultsServerViewController = ResultsServerViewController()
        // provide the results controller with the current searchText for its empty state view
        resultsServerViewController.searchText = ""
        
        // We want to be the delegate for our filtered table so didSelectRowAtIndexPath(_:) is called for both tables and any header actions
        resultsServerViewController.tableView.delegate = self
        
        // Setup the SearchController and the SearchController's searchBar
        searchController = UISearchController(searchResultsController: resultsServerViewController)
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        // Shift the searchBar to just under the navigation bar (not visible by default)
        tableView.contentOffset = CGPoint(x: 0, y: searchController.searchBar.frame.height)
        
        // set some options in preparation for the searchController
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = .serverListBackground
        
        let cancelButtonAttributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        definesPresentationContext = true
        
        // Listen for VPNKit Notifications
        NotificationCenter.default.addObserver(for: self)
        
        // Do the initial table setup
        // Fetch all of the cities from the APIManager
        if let fetchedCities = apiManager.fetchAllCities() as? [City] {
            
            // Convert the fetchedCities into CityModel objects
            let fetchedCityModels = fetchedCities.compactMap(CityModel.init)
            
            // Assign the initial data model to both the reference point (cityModels)
            cityModels = fetchedCityModels
        }
    }
    
    /// Helper method responsible for setting the accessibility labels and identifiers as well as localizations with our UI
    fileprivate func setupAccessibilityAndLocalization() {
        searchButton.accessibilityLabel = AccessibilityLabel.searchButton
        filterButton.accessibilityLabel = AccessibilityLabel.filterButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // provide the empty state view with the current information
        emptyStateView.searchText = searchController.searchBar.text ?? ""
        sortedModels = cityModels.sorted(by: sortOption)
        
        // reload the tableView
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state
        if restoredState.wasActive {
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // show the navigation bar just in case it was gone when the user made a selection
        if let isNavigationBarHidden = navigationController?.isNavigationBarHidden,
            isNavigationBarHidden == true {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If we're going to the filter view controller, assign it's delegate, the current ping and sort options, and the collection that it will display
        if let filterViewController = segue.destination as? FilterViewController {
            filterViewController.delegate = self
            filterViewController.selectedSortOption = sortOption
            filterViewController.fSortByOptions = fSortByOptions
        }
    }
    
    // MARK: IBActions
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    // MARK: - UITableViewDataSoure
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Need to provide room for best available
        if tableView === self.tableView {
            return sortedModels.count + 1
        } else {
            return sortedModels.count
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // we should crash if this isn't hooked up properly. Allows for easy debugging
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityServerTableViewCell.reuseIdentifier, for: indexPath) as? CityServerTableViewCell else {
            abort()
        }
        
        let cityModel: CityModel?
        if tableView == self.tableView {
            if indexPath.row == 0 {
                configureBestAvailable(cell)
            } else {
                cityModel = sortedModels[indexPath.row - 1]
                configure(cell, forCityModel: cityModel!)
            }
        } else {
            cityModel = resultsServerViewController.sortedCityModels[indexPath.row]
            configure(cell, forCityModel: cityModel!)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // update the vpnConfiguration based on the selection and bring the user back to the dashboard
        // We're handling both the ServerListViewController's table and ResultsServerViewController here
        var cityModel: CityModel?
        if tableView === self.tableView {
            if indexPath.row != 0 {
                cityModel = sortedModels[indexPath.row - 1]
            }
        } else {
            cityModel = resultsServerViewController.sortedCityModels[indexPath.row]
        }
        
        if let cityModel = cityModel {
            vpnConfiguration?.server = nil
            vpnConfiguration?.setCityAndCountry(cityModel.city)
        } else {
            vpnConfiguration?.server = nil
            vpnConfiguration?.city = nil
            vpnConfiguration?.country = nil
        }
        
        // go back to the dashboard
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    // MARK - UIStateRestoration
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        // Encode the view state so it can be restored later
        
        // Encode the searchController's active state
        coder.encode(searchController.isActive, forKey: RestorationKeys.searchControllerIsActive.rawValue)
        
        // Encode the first responder status
        coder.encode(searchController.searchBar.isFirstResponder, forKey: RestorationKeys.searchBarIsFirstResponder.rawValue)
        
        // Encode the search bar text
        coder.encode(searchController.searchBar.text, forKey: RestorationKeys.searchBarText.rawValue)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        // Restore the active state
        // We can't make the searchController active here since it's not part of the view hierarchy yet.
            // Instead, we do this in viewWillAppear
        restoredState.wasActive = coder.decodeBool(forKey: RestorationKeys.searchControllerIsActive.rawValue)
        
        // Restore the first responder status.
        // Same as above, we do this in viewWillAppear
        restoredState.wasFirstResponder = coder.decodeBool(forKey: RestorationKeys.searchBarIsFirstResponder.rawValue)
        
        // Restore the text in the search bar
        searchController.searchBar.text = coder.decodeObject(forKey: RestorationKeys.searchBarText.rawValue) as? String
    }
}


// MARK: - VPNServerStatusReporting
extension ServerListViewController: VPNServerStatusReporting {
    
    /// Used to update the list of PoPs and servers with new information.
    /// This method will be used to insert/delete any PoPs that have changed status from either online or offline to its opposite.
    /// This method will also filter and sort the resulting Data Model applying the FilterOptions of the ServerListViewController
    ///
    /// - parameter notification: Notification kicked back from the VPNKit. Object property holds Array of type Server
    func statusServerUpdateSucceeded(_ notification: Notification) {
        if serverUpdatePressed {
            // Set to false in the scenario the user tapped the `refresh servers` button to not show any more notifications unless pressed again
            serverUpdatePressed = false
        }
        
        // Get all of the cities from the APIManager
        guard let fetchedCities = apiManager.fetchAllCities() as? [City] else {
            return
        }
        
        // Convert the incoming fetched Cities into the CityModel objects
        let fetchedCityModels = fetchedCities.compactMap(CityModel.init)
        
        // 2. Replace base with newly updated fetched info
        self.cityModels = fetchedCityModels
        
        // 3. filter/sort using filteroptions into local variable and then diff against displayed filtered info.
        
        // Depending on which table is being displayed (ServerList - main table, ResultsController - search table),
        // update that data model and table
        let searchText = searchController.searchBar.text ?? ""
        let isSearchTableDisplayed = searchController.isActive && searchText.hasText
        
        if isSearchTableDisplayed {
            resultsServerViewController.sortedCityModels = self.cityModels.sorted(by: sortOption)
            resultsServerViewController.tableView.reloadData()
        } else {
            sortedModels = self.cityModels.sorted(by: sortOption)
            tableView.reloadData()
        }
        
        // Save out this moment in time for the last update
        UserDefaults.standard.set(Date(), forKey: Theme.lastUpdateKey)
        
    }
    
    /// Used to inform the user that the last Server Update failed.
    ///
    /// - parameter notification: Notification kicked back from NotificationCenter. Object property holds an NSError for the cause of the failure.
    func statusServerUpdateFailed(_ notification: Notification) {
        
        if serverUpdatePressed { // Only display something if the user manually attempted refresh
            
            // 1) If the network is reachable, tell the user they should contact support, otherwise
            // 2) Tell them to change their network settings (This should never happen since we're responding to this when refresh is selected)
            if apiManager.networkIsReachable {
                guard let error = notification.object as? Error else { // Contact Support
                    return
                }
                
                // This alert is to inform the user to contact support
                present(UIAlertController.contactSupport(with: error), animated: true, completion: nil)
                
            } else { // Change Settings
                present(UIAlertController.network(), animated: true, completion: nil)
            }
            
            // Set to false in the scenario the user tapped the `refresh servers` button to not show any more notifications unless pressed again
            serverUpdatePressed = false
            
            // re-enable the emptyView's reloadServersButton in the case it failed
            emptyStateView.reloadServersButton?.isEnabled = true
        }
        
        // Since we failed, erase the last successful update
        UserDefaults.standard.set(nil, forKey: Theme.lastUpdateKey)
    }
}

// MARK: - FilterViewControllerDelegate
extension ServerListViewController: FilterViewControllerDelegate {
    
    func filterViewController(_ filterViewController: FilterViewController, selected sortOption: SortOption) {
        self.sortOption = sortOption
        
        // Save this to UserDefaults
        UserDefaults.standard.set(fSortByOptions.firstIndex(of: sortOption) ?? 0, forKey: Theme.sortOptionKey)
    }
}

// MARK: - UISearchBarDelegate
extension ServerListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the results controller's empty state view to have most up to date search text
        // Our empty state view doesn't need this info as it will never be displayed when there is text
        resultsServerViewController.searchText = searchText
    }
    
}

// MARK: - UISearchResultsUpdating
extension ServerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        // Just because the searchController is active does not mean its content is displayed. Because of this, we should only work with it if
            // it is both active and the searchBar has text
        
        // Strip out all the leading and trailing spaces
        let searchText = searchController.searchBar.text ?? ""
        let strippedString = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        let isSearchTableDisplayed = searchController.isActive && strippedString.hasText
        
        if isSearchTableDisplayed {
            // Filter our reference point down using what options the user has set and pass off to the search results controller
            guard let resultsController = searchController.searchResultsController as? ResultsServerViewController else {
                return
            }
            resultsController.sortedCityModels = cityModels.filtered(withName: strippedString)
                                                           .sorted(by: sortOption)
            
            // reload the table with the changes
            resultsController.tableView.reloadData()
            
        } else {
            // Filter our reference point down using only the filter options and sort options and display on main table view
            sortedModels = cityModels.filtered(withName: strippedString)
                                     .sorted(by: sortOption)
            
            // reload our table with the changes
            tableView.reloadData()
        }
    }
}

// MARK: - EmptyStateViewDelegate
extension ServerListViewController: EmptyStateViewDelegate {
    func reloadServersTapped(in emptyStateView: EmptyStateView) {
        // this should never happen from the results view controller, but just make sure anyway
        guard emptyStateView === self.emptyStateView else {
            return
        }
        
        // 1) If the network is reachable,
            // a) Refresh the servers if it has been more than 5 minutes since the last successful update OR
            // b) Inform the user the servers are already up to date, otherwise
        // 2) Tell the user to change their network settings
        
        if apiManager.networkIsReachable {
            // Has it been more than 5 minutes (300 seconds) since the last successful update?
            let lastUpdate = UserDefaults.standard.value(forKey: Theme.lastUpdateKey) as? Date ?? Date.distantPast
            if Date().timeIntervalSince(lastUpdate) > 300 { // Update servers
                serverUpdatePressed = true
                apiManager.updateServerList()
            }
        } else { // Change Network Settings
            present(UIAlertController.network(), animated: true, completion: nil)
        }
    }
}
