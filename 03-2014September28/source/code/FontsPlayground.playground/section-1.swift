// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


for familyName in UIFont.familyNames() as [String] {
    for fontName in UIFont.fontNamesForFamilyName(familyName) as [String] {
        println(fontName)
    }
}