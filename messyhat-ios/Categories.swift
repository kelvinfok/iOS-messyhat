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
        sections = ["Tech", "Arts", "Sports", "Business"]
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
        newCategories += Technology.categories()
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

class Technology
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "WIRED", image: UIImage(named: "coding")!, section: "Technology"))
        categories.append(Category(title: "WIRED", image: UIImage(named: "design")!, section: "Technology"))
        
        return categories
    }
}







