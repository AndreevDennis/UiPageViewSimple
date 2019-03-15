//
//  MyPageViewController.swift
//  UiPageViewSimple
//
//  Created by Denis Andreev on 15.03.2019.
//  Copyright © 2019 353. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController {
    
    private (set) lazy var orderedViewContorllers:[UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RedVC"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GreenVC"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlueVC"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrangeVC")
        ]
    }()
    
    override func viewDidLoad() {
        if let firstVC = orderedViewContorllers.first {
            setViewControllers([firstVC],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            dataSource = self
        }
    }
}

extension MyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewContorllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard orderedViewContorllers.count > previousIndex else {return nil}
        return orderedViewContorllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewContorllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard orderedViewContorllers.count != nextIndex else {return nil}
        guard orderedViewContorllers.count > nextIndex else {return nil}
        return orderedViewContorllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewContorllers.count
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = self.orderedViewContorllers.index(of: firstViewController) else { return 0 }
        return firstViewControllerIndex
    }
    
}
