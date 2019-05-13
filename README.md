# PinPoint
A place searching app built with Flutter that pulls and renders information from Google's Places and Place Details API

## Technologies Used:
This app was built using only Flutter and uses installed packages that can be found listed in this projects pubspec.yaml file.

## To run live:
*Must have Flutter packages installed - Must have Google API key*

1) Clone project
2) Create an AppDelegate.m file appended to the following relative path: (i.e. /pinpoint/ios/Runner/AppDelegate.m)

3) Paste following code into AppDelegate.m file, pasting in Google API key where indicated:

```
    #include "AppDelegate.h"
    #include "GeneratedPluginRegistrant.h"
    // Add the GoogleMaps import.
    #import "GoogleMaps/GoogleMaps.h"

    @implementation AppDelegate

    - (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Add the following line with your API key.
    [GMSServices provideAPIKey:@"YOUR IOS API KEY HERE"];
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
    }
    @end   
```

4) Run project using ```$Flutter run```


![](PinPoint.gif)