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
    
    static var subCategories = ["Startup - Early Stage", "Startup - Ecommerce", "Startup - Finance", "Startup - Biotech", "Startup - IOT", "Startup - Healthcare",  "Startup - Security", "Startup - Logistics", "Startup - Virtual Reality", "Startup - Clean Tech", "Startup - Legal", "Startup - Social Media", "Startup - Data", "Startup - Marketing", "Startup - Travel", "Code - Ruby on Rails", "Code - Javascript", "Code - ASP.NET",
                                "Code - Django", "Code - PHP", "Code - Java", "Code - Swift", "Code - Haskell"]
    
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
        sections = ["Startups", "Code"]
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
        newCategories += Startups.categories()
        newCategories += Code.categories()


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


class Startups
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "Early Stage", image: UIImage(named: "startups-earlystage")!, section: "Startups"))
        categories.append(Category(title: "E-commerce", image: UIImage(named: "startups-ecommerce")!, section: "Startups"))
        categories.append(Category(title: "Fintech", image: UIImage(named: "startups-finance")!, section: "Startups"))
        categories.append(Category(title: "Biotech", image: UIImage(named: "startups-biotech")!, section: "Startups"))
        categories.append(Category(title: "IOT", image: UIImage(named: "startups-iot")!, section: "Startups"))
        categories.append(Category(title: "Health Care", image: UIImage(named: "startups-healthcare")!, section: "Startups"))
        categories.append(Category(title: "Security", image: UIImage(named: "startups-security")!, section: "Startups"))
        categories.append(Category(title: "Logistics", image: UIImage(named: "startups-logistics")!, section: "Startups"))
        categories.append(Category(title: "Virtual Reality", image: UIImage(named: "startups-virtualreality")!, section: "Startups"))
        categories.append(Category(title: "Energy", image: UIImage(named: "startups-cleantech")!, section: "Startups"))
        categories.append(Category(title: "Legal", image: UIImage(named: "startups-legal")!, section: "Startups"))
        categories.append(Category(title: "Social Media", image: UIImage(named: "startups-socialmedia")!, section: "Startups"))
        categories.append(Category(title: "Data", image: UIImage(named: "startups-data")!, section: "Startups"))
        categories.append(Category(title: "Marketing", image: UIImage(named: "startups-marketing")!, section: "Startups"))
        categories.append(Category(title: "Travel", image: UIImage(named: "startups-travel")!, section: "Startups"))

        return categories
    }
}


class Code
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "Ruby on Rails", image: UIImage(named: "code-rails")!, section: "Code"))
        categories.append(Category(title: "Javascript", image: UIImage(named: "code-javascript")!, section: "Code"))
        categories.append(Category(title: "ASP.NET", image: UIImage(named: "code-aspnet")!, section: "Code"))
        categories.append(Category(title: "Django", image: UIImage(named: "code-django")!, section: "Code"))
        categories.append(Category(title: "PHP", image: UIImage(named: "code-php")!, section: "Code"))
        categories.append(Category(title: "Java", image: UIImage(named: "code-java")!, section: "Code"))
        categories.append(Category(title: "Swift", image: UIImage(named: "code-swift")!, section: "Code"))
        categories.append(Category(title: "Haskell", image: UIImage(named: "code-haskell")!, section: "Code"))
        return categories
    }
}


