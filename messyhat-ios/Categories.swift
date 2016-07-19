//
//  Categories.swift
//  messyhat-ios
//
//  Created by kelvinfok on 19/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//


import UIKit

class Categories
{
    private var categories = [Category]()
    private var immutableCategories = [Category]()
    private var sections = [String]()
    
    // MARK: - Public
    
    var numberOfCategories: Int {
        return categories.count
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    init()
    {
        categories = createCategories()
        immutableCategories = categories
        sections = ["Code", "Design", "Marketing", "Data"]
    }
    
    func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath])
    {
        var indexes = [Int]()
        for indexPath in indexPaths {
            indexes.append(absoluteIndexForIndexPath(indexPath))
        }
        var newCategories = [Category]()
        for (index, category) in categories.enumerate() {
            if !indexes.contains(index) {
                newCategories.append(category)
            }
        }
        categories = newCategories
    }
    
    func moveCategoryFromIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        if indexPath != newIndexPath {
            let index = absoluteIndexForIndexPath(indexPath)
            let category = categories[index]
            category.section = sections[newIndexPath.section]
            let newIndex = absoluteIndexForIndexPath(newIndexPath)
            categories.removeAtIndex(index)
            categories.insert(category, atIndex: newIndex)
        }
    }
    
    func indexPathForNewRandomPublisher() -> NSIndexPath
    {
        let index = Int(arc4random_uniform(UInt32(immutableCategories.count)))
        let categoryToCopy = immutableCategories[index]
        let newPublisher = Category(copies: categoryToCopy)
        categories.append(newPublisher)
        categories.sortInPlace { $0.section < $1.section }
        return indexPathForCategory(newPublisher)
    }
    
    func indexPathForCategory(category: Category) -> NSIndexPath
    {
        let section = sections.indexOf(category.section)
        var item = 0
        for (index, currentCategory) in categoriesForSection(section!).enumerate() {
            if currentCategory === category {
                item = index
                break
            }
        }
        return NSIndexPath(forItem: item, inSection: section!)
    }
    
    func numberOfCategoriesInSection(index: Int) -> Int {
        let categories = categoriesForSection(index)
        return categories.count
    }
    
    func categoryForItemAtIndexPath(indexPath: NSIndexPath) -> Category? {
        if indexPath.section > 0 {
            let categories = categoriesForSection(indexPath.section)
            return categories[indexPath.item]
        } else {
            return categories[indexPath.item]
        }
    }
    
    func titleForSectionAtIndexPath(indexPath: NSIndexPath) -> String?
    {
        if indexPath.section < sections.count {
            return sections[indexPath.section]
        }
        return nil
    }
    
    // MARK: - Private
    
    private func createCategories() -> [Category]
    {
        var newCategories = [Category]()
        newCategories += Code.categories()
        newCategories += Design.categories()
        newCategories += Marketing.categories()
        newCategories += Data.categories()
        return newCategories
    }
    
    private func absoluteIndexForIndexPath(indexPath: NSIndexPath) -> Int
    {
        var index = 0
        for i in 0..<indexPath.section {
            index += numberOfCategoriesInSection(i)
        }
        index += indexPath.item
        return index
    }
    
    private func categoriesForSection(index: Int) -> [Category] {
        let section = sections[index]
        let categoriesInSection = categories.filter {
            (category: Category) -> Bool in return category.section == section
        }
        return categoriesInSection
    }
}

class Code
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "Web", image: UIImage(named: "code-web")!, section: "Code"))
        categories.append(Category(title: "Mobile", image: UIImage(named: "code-mobile")!, section: "Code"))
        categories.append(Category(title: "Game", image: UIImage(named: "code-game")!, section: "Code"))
        
        return categories
    }
}

class Design
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "UX/UI", image: UIImage(named: "design-uxui")!, section: "Design"))
        categories.append(Category(title: "Game", image: UIImage(named: "design-game")!, section: "Design"))
        categories.append(Category(title: "Media", image: UIImage(named: "design-media")!, section: "Design"))
        
        return categories
    }
}

class Marketing
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "SEO", image: UIImage(named: "marketing")!, section: "Marketing"))
        categories.append(Category(title: "Content", image: UIImage(named: "marketing")!, section: "Marketing"))
        categories.append(Category(title: "Social Media", image: UIImage(named: "marketing")!, section: "Marketing"))
        
        return categories
    }
}

class Data
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "Statistics", image: UIImage(named: "data")!, section: "Data"))
        categories.append(Category(title: "Machine Learning", image: UIImage(named: "data")!, section: "Data"))
        
        return categories
    }
}

