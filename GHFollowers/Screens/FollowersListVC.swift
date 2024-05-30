//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/27.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject{
    func didRequestForFollowers(for username:String)
    
}

class FollowersListVC: GFDataLoadingVC {

    enum Section{
        case main
    }
    
    var userName:String!
    var followers:[Follower]         = []
    var filteredFollowers:[Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section,Follower>!
    
    init(username:String){
        super.init(nibName: nil, bundle: nil)
        self.userName = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: userName, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureSearchController() {
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "search for username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout:UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers(username:String, page:Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) {[weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result{
                case .success(let followers):
                    if followers.count < 100 {self.hasMoreFollowers = false}
                    self.followers.append(contentsOf: followers)
                    
                    if self.followers.isEmpty {
                        let message = "this user has not any followers, pls follow them"
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                
                self.updateData(on: self.followers)

                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "bad stuff happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView,
                                                                          cellProvider: {(collectionView, indexPath, follower)-> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers:[Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
        
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: userName) {[weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
                case .success(let user):
                    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                    PersistenceManager.updateWith(favourite: favorite, actiontype: .add) { [weak self] error in
                        guard let self = self else {return}
                        
                        guard let error = error else {
                            self.presentGFAlertOnMainThread(title: "success", message: "you have success save the value", buttonTitle: "ok")
                            return
                        }
                        self.presentGFAlertOnMainThread(title: "network error", message: error.rawValue, buttonTitle: "ok")
                    }
                
                case .failure(let error):
                self.presentGFAlertOnMainThread(title: "network error", message: error.rawValue, buttonTitle: "ok")
            }
        }
        
    }
}

extension FollowersListVC:UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY        = scrollView.contentOffset.y
        let contentHeight  = scrollView.contentSize.height
        let height         = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else {return}
            page += 1
            getFollowers(username:userName,page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers: followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension FollowersListVC:UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased())})
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}


extension FollowersListVC: FollowerListVCDelegate {
    
    func didRequestForFollowers(for username: String) {
        self.userName = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}

