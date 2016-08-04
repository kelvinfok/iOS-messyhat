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
    
    static var subCategories = ["Startup - Early Stage", "Startup - E-commerce", "Startup - Finance", "Startup - Biotech", "Startup - IOT", "Startup - Healthcare",  "Startup - Security", "Startup - Logistics", "Startup - Virtual Reality", "Startup - Clean Tech", "Startup - Legal", "Startup - Social Media", "Startup - Data", "Startup - Marketing", "Startup - Travel", "Code - Ruby on Rails", "Code - Javascript", "Code - ASP.NET",
                                "Code - Django", "Code - PHP", "Code - Java", "Code - Swift", "Code - Haskell",
                                "Code - C++"]
    
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
        sections = ["Startup", "Code"]
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
        newCategories += Startup.categories()
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


class Startup
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "Early Stage", key: "Startup - Early Stage", image: UIImage(named: "startups-earlystage")!, section: "Startup"))
        categories.append(Category(title: "E-commerce", key: "Startup - E-commerce", image: UIImage(named: "startups-ecommerce")!, section: "Startup"))
        categories.append(Category(title: "Finance", key: "Startup - Finance", image: UIImage(named: "startups-finance")!, section: "Startup"))
        categories.append(Category(title: "Biotech", key: "Startup - Biotech", image: UIImage(named: "startups-biotech")!, section: "Startup"))
        categories.append(Category(title: "IOT", key: "Startup - IOT", image: UIImage(named: "startups-iot")!, section: "Startup"))
        categories.append(Category(title: "Health Care", key: "Startup - Healthcare", image: UIImage(named: "startups-healthcare")!, section: "Startup"))
        categories.append(Category(title: "Security", key: "Startup - Security", image: UIImage(named: "startups-security")!, section: "Startup"))
        categories.append(Category(title: "Logistics", key: "Startup - Logistics", image: UIImage(named: "startups-logistics")!, section: "Startup"))
        categories.append(Category(title: "Virtual Reality", key: "Startup - Virtual Reality", image: UIImage(named: "startups-virtualreality")!, section: "Startup"))
        categories.append(Category(title: "Clean Tech", key: "Startup - Clean Tech", image: UIImage(named: "startups-cleantech")!, section: "Startup"))
        categories.append(Category(title: "Legal", key: "Startup - Legal", image: UIImage(named: "startups-legal")!, section: "Startup"))
        categories.append(Category(title: "Social Media", key: "Startup - Social Media", image: UIImage(named: "startups-socialmedia")!, section: "Startup"))
        categories.append(Category(title: "Data", key: "Startup - Data", image: UIImage(named: "startups-data")!, section: "Startup"))
        categories.append(Category(title: "Marketing", key: "Startup - Marketing", image: UIImage(named: "startups-marketing")!, section: "Startup"))
        categories.append(Category(title: "Travel", key: "Startup - Travel", image: UIImage(named: "startups-travel")!, section: "Startup"))

        return categories
    }
}

class Code
{
    class func categories() -> [Category]
    {
        var categories = [Category]()
        categories.append(Category(title: "Ruby on Rails", key: "Code - Ruby on Rails", image: UIImage(named: "code-rails")!, section: "Code"))
        categories.append(Category(title: "Javascript", key: "Code - Javascript", image: UIImage(named: "code-javascript")!, section: "Code"))
        categories.append(Category(title: "ASP.NET", key: "Code - ASP.NET", image: UIImage(named: "code-aspnet")!, section: "Code"))
        categories.append(Category(title: "Django", key: "Code - Django", image: UIImage(named: "code-django")!, section: "Code"))
        categories.append(Category(title: "PHP", key: "Code - PHP", image: UIImage(named: "code-php")!, section: "Code"))
        categories.append(Category(title: "Java", key: "Code - Java", image: UIImage(named: "code-java")!, section: "Code"))
        categories.append(Category(title: "Swift", key: "Code - Swift", image: UIImage(named: "code-swift")!, section: "Code"))
        categories.append(Category(title: "Haskell", key: "Code - Haskell", image: UIImage(named: "code-haskell")!, section: "Code"))
        categories.append(Category(title: "C++", key: "Code - C++", image: UIImage(named: "code-cpp")!, section: "Code"))
        return categories
    }
}


