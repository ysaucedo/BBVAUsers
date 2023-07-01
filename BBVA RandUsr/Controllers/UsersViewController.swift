//
//  UsersViewController.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 30/06/23.
//

import UIKit

class UsersViewController: UIViewController {
    
    private let viewModel = UsersViewModel()

    var categorySegmented: UISegmentedControl!
    var collectionView: UICollectionView!
    var showLoader: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        configureCollection()
        setupBinding()
        if showLoader { viewModel.loaderProtocol = self }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setupBinding() {
        viewModel.arrUsers.bindTo { [weak self] _ in
            DispatchQueue.main.async { self?.collectionView.reloadData() }
        }
    }
    
    private func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupUI() {
        
        navigationController?.setNavigationBarHidden(false, animated: false)

        self.title = NSLocalizedString(Text.listUsers, comment: Text.localizable)
        view.backgroundColor = .blue

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.list?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(menuOptions(_ :)))

                
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 24.0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - 20, height: 300)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: Constant.usercell)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([

            collectionView.topAnchor.constraint(equalTo: margins.topAnchor, constant: Size.spaceElement),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    private func setupNavigationBar() {
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            appearance.backgroundColor = UIColor.init(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
            
    @objc private func menuOptions(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: NSLocalizedString(Text.whatDo, comment:Text.localizable), preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: NSLocalizedString(Text.logout, comment:Text.localizable), style: .destructive, handler: { [weak self] _ in
            
            guard let self = self else { return }
            
            self.navigationController?.popToRootViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString(Text.cancel, comment:Text.localizable), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeContextMenu(for index: Int) -> UIMenu {
        let favorites = UIAction(title: NSLocalizedString(Text.details, comment:Text.localizable), image: Image.list) { [weak self] action in
            guard let self = self else { return }
            let vc = self.viewModel.instanciateDetail() as! UserDetailViewController
            vc.user = self.viewModel.getUser(at: index)
            self.present(vc, animated: true, completion: nil)
        }
        
        return UIMenu(title: NSLocalizedString(Text.actions, comment:Text.localizable), children: [favorites])
        
    }

}

// MARK: - UIScrollViewDelegate Conformance
extension UsersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height {
            if !viewModel.scrollActivate {
                viewModel.service.nextPage()
                viewModel.fetchUsers()
            }
        }
    }
}

extension UsersViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = viewModel.instanciateDetail() as! UserDetailViewController
        vc.user = viewModel.getUser(at: indexPath.item)
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu(for: indexPath.row)
        })
        
    }
    
}

extension UsersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewModel.arrUsers.value?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.usercell, for: indexPath) as? UserCollectionViewCell {
            cell.setupCell(user: viewModel.getUser(at: indexPath.item)!)
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

extension UsersViewController: LoaderProtocol {
    func startLoading() {
        let vc = viewModel.instanciateLoader()
        present(vc, animated: false, completion: nil)
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            if let vc = self.navigationController?.visibleViewController {
                if vc.isKind(of: LoaderViewController.self) {         self.navigationController?.visibleViewController?.dismiss(animated: false)
                }
            }
        }
    }
    
}
