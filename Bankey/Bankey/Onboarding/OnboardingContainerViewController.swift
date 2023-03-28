//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Josh on 3/27/23.
//

import UIKit

// MARK: - OnboardingContainerViewControllerDelegate
protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

// MARK: - OnboardingContainerViewController
class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(imageName: "delorean", titleText: "Bankey is a faster, easier to use, and has a brand new look and feel that will make you feel ike you are back in 89'")
        let page2 = OnboardingViewController(imageName: "world", titleText: "Move your money around the world quickly and securely")
        let page3 = OnboardingViewController(imageName: "thumbs", titleText: "Learn more at www.bankey.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()

    }
    
    private func setup() {
        view.backgroundColor = .systemPurple
        
        /*
         How to add child view controllers to a parent view controller
         take child and adding it to the container(self)
         then take childs view add to subview , our view (OnBoardingContainerVC)
         call did Move on the child and we say did move to parent self, hooks up all UIVC
         */
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // protocol-delegate, we are going to be the source of data for x amount of pages it has
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        view.addSubview(closeButton)
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            
        ])
        
    }
    
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}
// MARK: - Actions
extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
        print("foo - closing onboard")
    }
    
}
