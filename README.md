# RealmDemo
This is a simple iOS application to demonstrate how to set up a Realm mobile database and use basic insert, query, and delete functions. It also shows how to create a mock Realm database for unit testing.

## Steps to setup RealmSwift CocoaPods
Terminal Command (if haven't used CocoaPods before)
```
sudo gem install cocoapods
```

### Navigate to directory that holds .xcodeproj file
Terminal Command
```
pod init
```

### Edit Podfile
```
platform :ios, '10.0'

target 'RealmDemo' do
  use_frameworks!
  pod 'RealmSwift'
end
```

### Install Pods
```
pod install
```

### Build the .xcworkspace file and work from it from now on