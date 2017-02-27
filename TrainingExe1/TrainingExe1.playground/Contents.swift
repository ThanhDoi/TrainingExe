//: Playground - noun: a place where people can play

import UIKit

// 1.1
var string = "Hello World"

// 1.2
for i in 1...15 {
    print("*", terminator: "")
}
print()
for i in 1...10 {
    print("*             *")
}
for i in 1...15 {
    print("*", terminator: "")
}
print()

// 1.3
var array1 : [String] = ["A", "B", "C"]
var array2 = array1 + ["D"]

print(array1)
print(array2)

// 1.4
var dictionary1 = [String:[String]]()
dictionary1["Thanh"] = ["22", "HN", "01655993824"]
for (key, value) in dictionary1 {
    print(key)
}

// 1.5
func sortAge(firstDict : [String : Any], secondDict : [String : Any]) -> Bool {
    return (firstDict["Age"] as! Int) < (secondDict["Age"] as! Int)
}
var thongTinNguoiDung = [["Name" : "Thanh", "Age" : 25, "Adress" : "Thanh Tri", "Phone" : "123"],
                         ["Name" : "Anh", "Age" : 24, "Adress" : "Thanh Tri", "Phone" : "456"],
                         ["Name" : "Hung", "Age" : 23, "Adress" : "My Dinh", "Phone" : "789"]]
thongTinNguoiDung.sort { (firstDict : [String : Any], secondDict : [String : Any]) -> Bool in return(sortAge(firstDict: firstDict, secondDict: secondDict))
}

print(thongTinNguoiDung)
