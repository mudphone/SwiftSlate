I added ReactiveCocoa as a git submodule, to facilitate experimenatation/hacking for Swift compatibility. Normally, I would just use the CocoaPod (which is a much simpler way to get started with RAC). Consider yourself warned.

Things I did:
- Create a new Swift project
- add gitignore to new Swift project
- git submodule add https://github.com/ReactiveCocoa/ReactiveCocoa.git ReactiveCocoa
- git submodule update --init --recursive

See ReactiveCocoa README for these steps:
- Drag and drop ReactiveCocoaFramework/ReactiveCocoa.xcodeproj into your application's Xcode project or workspace.
- On the "Build Phases" tab of your application target, add RAC to the "Link Binary With Libraries" phase. On iOS, add libReactiveCocoa-iOS.a
- Add "$(BUILD_ROOT)/../IntermediateBuildFilesPath/UninstalledProducts/include" $(inherited) to the "Header Search Paths" build setting (this is only necessary for archive builds, but it has no negative effect otherwise). This is under the target's "Build Settings"
- Add -ObjC to the "Other Linker Flags" build setting. This is under the target's "Build Settings"

Bridging Header:
- Create ReactiveSwift-Bridging-Header.h and add this: `#import <ReactiveCocoa/ReactiveCocoa.h>` (from: https://medium.com/@stigi/swift-cocoapods-da09d8ba6dd2)

