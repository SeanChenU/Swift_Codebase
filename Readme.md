## Usage ##

### Add git submodule
`git submodule add https://github.com/SeanChenU/Swift_Codebase.git`
`git submodule init`
`git submodule update`

In the project root folder, there will be a “Swift_Codebase” folder in it.

Create a “group” in current project named “Swift_Codebase” (optional) and drag the files needed into current project.

### Updating submodule
git pull --recurse-submodules
git submodule update --recursive

### Removing git module
git remove Swift_Codebase
rm -rf .git/modules/Swift_Codebase

## To-do ##

Integrate all libs that are useful.

Pods:

1. SwiftyJSON / For json handling
2. Alamofire / For networking

Next:

1. ActivityIndicator

Current Codebase:

1. FileHelper / Handing file related works.
2. PhotoMaster / Handling image picker realted works.

